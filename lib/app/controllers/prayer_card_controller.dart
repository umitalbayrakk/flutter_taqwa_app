import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:flutter_taqwa_app/views/prayer_selected_time/prayer_time_view.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class PrayerController extends GetxController {
  final GetStorage _storage = GetStorage();

  var selectedPlace = 'Beşiktaş / İstanbul'.obs;
  var todayTimes = ['00:00', '00:00', '00:00', '00:00', '00:00', '00:00'].obs;

  var nextPrayerName = ''.obs;
  var nextPrayerDuration = Rxn<Duration>();
  var formattedDate = ''.obs;
  var formattedHijriDate = ''.obs;

  Timer? _timer;

  final List<String> prayerNames = ['İmsak', 'Güneş', 'Öğle', 'İkindi', 'Akşam', 'Yatsı'];
  var currentPrayerIndex = RxnInt();

  final Map<int, String> turkishHijriMonths = {
    1: 'Muharrem',
    2: 'Safer',
    3: 'Rebîülevvel',
    4: 'Rebîülâhir',
    5: 'Cemâziyelevvel',
    6: 'Cemâziyelâhir',
    7: 'Recep',
    8: 'Şaban',
    9: 'Ramazan',
    10: 'Şevval',
    11: 'Zilkade',
    12: 'Zilhicce',
  };

  @override
  void onInit() {
    super.onInit();

    initializeDateFormatting('tr_TR', null).then((_) {
      final now = DateTime.now();
      formattedDate.value = DateFormat("d MMMM y EEEE", "tr_TR").format(now);
      final hijriDate = HijriCalendar.fromDate(now);
      formattedHijriDate.value = "${hijriDate.hDay} ${turkishHijriMonths[hijriDate.hMonth]} ${hijriDate.hYear}";
    });

    final savedPlace = _storage.read<String>('selected_place');
    final savedTimes = _storage.read<List>('today_times');

    if (savedPlace != null && savedTimes != null) {
      selectedPlace.value = savedPlace;
      todayTimes.value = List<String>.from(savedTimes);
      _calculateNextPrayerTime();
      _startTimer();
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  String formatDuration(Duration d) {
    final h = d.inHours.toString().padLeft(2, '0');
    final m = (d.inMinutes % 60).toString().padLeft(2, '0');
    final s = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  Future<void> navigateAndFetchPrayerTimes() async {
    final result = await Get.to(() => const PrayerTimesScreen());

    if (result != null) {
      final times = result['times'] as Map<String, dynamic>;
      final place = result['place'] as String;
      updatePrayerTimes(times, place);
    }
  }

  void updatePrayerTimes(Map<String, dynamic> times, String place) {
    final todayKey = times.keys.first;
    final timesList = List<String>.from(times[todayKey]);

    selectedPlace.value = place;
    todayTimes.value = timesList;

    _storage.write('selected_place', place);
    _storage.write('today_times', timesList);

    _calculateNextPrayerTime();
    _startTimer();

    final now = DateTime.now();
    final hijriDate = HijriCalendar.fromDate(now);
    formattedHijriDate.value = "${hijriDate.hDay} ${turkishHijriMonths[hijriDate.hMonth]} ${hijriDate.hYear}";
  }

  void _calculateNextPrayerTime() {
    if (todayTimes.contains('--:--')) {
      nextPrayerDuration.value = null;
      nextPrayerName.value = '';
      return;
    }

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    for (var i = 0; i < todayTimes.length; i++) {
      final parts = todayTimes[i].split(':');
      final prayerTime = DateTime(today.year, today.month, today.day, int.parse(parts[0]), int.parse(parts[1]));
      if (prayerTime.isAfter(now)) {
        nextPrayerDuration.value = prayerTime.difference(now);
        nextPrayerName.value = prayerNames[i];
        currentPrayerIndex.value = i - 1 < 0 ? null : i - 1; //  Şu anki vakit
        return;
      }
    }

    final parts = todayTimes[0].split(':');
    final nextImsak = today
        .add(const Duration(days: 1))
        .copyWith(hour: int.parse(parts[0]), minute: int.parse(parts[1]));

    nextPrayerDuration.value = nextImsak.difference(now);
    nextPrayerName.value = 'İmsak';
    currentPrayerIndex.value = 5; // Son vakit: Yatsı
  }

  String getIconFileName(int index) {
    switch (index) {
      case 0:
        return "imsaq";
      case 1:
        return "sunny";
      case 2:
        return "noon";
      case 3:
        return "afternoon";
      case 4:
        return "night";
      case 5:
        return "isha";
      default:
        return "sunny";
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _calculateNextPrayerTime();

      final now = DateTime.now();
      final hijriDate = HijriCalendar.fromDate(now);
      final newHijriDate = "${hijriDate.hDay} ${turkishHijriMonths[hijriDate.hMonth]} ${hijriDate.hYear}";
      if (formattedHijriDate.value != newHijriDate) {
        formattedHijriDate.value = newHijriDate;
      }
    });
  }

  void navigateWithSlideTransition(BuildContext context, Widget page) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = const Offset(1.0, 0.0);
          var end = Offset.zero;
          var curve = Curves.ease;
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
    );
  }
}
