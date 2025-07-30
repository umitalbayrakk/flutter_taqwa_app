import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_taqwa_app/core/utils/app_colors.dart';
import 'package:flutter_taqwa_app/views/prayer_selected_time/prayer_time_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class PrayerController extends GetxController {
  final GetStorage _storage = GetStorage();

  var selectedPlace = 'Beşiktaş / İstanbul'.obs;
  var todayTimes = ['00:00', '00:00', '00:00', '00:00', '00:00', '00:00'].obs;
  var nextPrayerName = ''.obs;
  var nextPrayerDuration = Rxn<Duration>();
  var formattedDate = ''.obs;
  var formattedHijriDate = ''.obs;
  var selectedBackgroundIndex = 0.obs;
  var currentPrayerIndex = RxnInt();
  var currentPrayerSlotIndex = RxnInt();

  Timer? _timer;

  final List<String> prayerNames = ['İmsak', 'Güneş', 'Öğle', 'İkindi', 'Akşam', 'Yatsı'];

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
      updateDates();
    });

    final savedPlace = _storage.read<String>('selected_place');
    final savedTimes = _storage.read<List>('today_times');
    final bgIndex = _storage.read<int>('background_index');

    if (savedPlace != null && savedTimes != null) {
      selectedPlace.value = savedPlace;
      todayTimes.value = List<String>.from(savedTimes);
      _calculatePrayerTimes();
      _startTimer();
    }

    if (bgIndex != null) selectedBackgroundIndex.value = bgIndex;
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void updateDates() {
    final now = DateTime.now();
    formattedDate.value = DateFormat("d MMMM y EEEE", "tr_TR").format(now);
    updateHijriDate(now);
  }

  void updateHijriDate(DateTime date) {
    final hijriDate = HijriCalendar.fromDate(date);
    formattedHijriDate.value = "${hijriDate.hDay} ${turkishHijriMonths[hijriDate.hMonth]} ${hijriDate.hYear}";
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

    _calculatePrayerTimes();
    _startTimer();
    updateDates();
  }

  void _calculatePrayerTimes() {
    if (todayTimes.contains('--:--')) {
      nextPrayerDuration.value = null;
      nextPrayerName.value = '';
      currentPrayerIndex.value = null;
      currentPrayerSlotIndex.value = null;
      return;
    }

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    // Reset values
    currentPrayerIndex.value = null;
    nextPrayerName.value = '';
    nextPrayerDuration.value = null;

    // Find current prayer time
    for (var i = 0; i < todayTimes.length; i++) {
      final parts = todayTimes[i].split(':');
      final prayerTime = DateTime(today.year, today.month, today.day, int.parse(parts[0]), int.parse(parts[1]));

      DateTime nextPrayerTime;
      if (i + 1 < todayTimes.length) {
        final nextParts = todayTimes[i + 1].split(':');
        nextPrayerTime = DateTime(today.year, today.month, today.day, int.parse(nextParts[0]), int.parse(nextParts[1]));
      } else {
        // For Yatsı, next prayer is tomorrow's Imsak
        final nextParts = todayTimes[0].split(':');
        nextPrayerTime = today
            .add(const Duration(days: 1))
            .copyWith(hour: int.parse(nextParts[0]), minute: int.parse(nextParts[1]));
      }

      if (now.isAfter(prayerTime)) {
        if (now.isBefore(nextPrayerTime)) {
          currentPrayerIndex.value = i;
          currentPrayerSlotIndex.value = i;
        }
      }
    }

    // Find next prayer time
    for (var i = 0; i < todayTimes.length; i++) {
      final parts = todayTimes[i].split(':');
      final prayerTime = DateTime(today.year, today.month, today.day, int.parse(parts[0]), int.parse(parts[1]));

      if (prayerTime.isAfter(now)) {
        nextPrayerDuration.value = prayerTime.difference(now);
        nextPrayerName.value = prayerNames[i];
        break;
      }
    }

    // If no next prayer found today, it's tomorrow's Imsak
    if (nextPrayerName.value.isEmpty) {
      final parts = todayTimes[0].split(':');
      final nextImsak = today
          .add(const Duration(days: 1))
          .copyWith(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
      nextPrayerDuration.value = nextImsak.difference(now);
      nextPrayerName.value = 'İmsak';
    }

    // Special case: Between Yatsı and Imsak
    if (currentPrayerIndex.value == null && now.isAfter(DateTime(today.year, today.month, today.day, 23, 59))) {
      currentPrayerIndex.value = 5; // Yatsı index
    }
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
      _calculatePrayerTimes();
      final now = DateTime.now();
      final newHijriDate = HijriCalendar.fromDate(now);
      final newHijriDateStr = "${newHijriDate.hDay} ${turkishHijriMonths[newHijriDate.hMonth]} ${newHijriDate.hYear}";

      if (formattedHijriDate.value != newHijriDateStr) {
        formattedHijriDate.value = newHijriDateStr;
      }
    });
  }

  void changeBackground(int index) {
    selectedBackgroundIndex.value = index;
    _storage.write('background_index', index);
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

  Decoration getBackground(int index) {
    switch (index) {
      case 0:
        return BoxDecoration(color: AppColors.orangeColor, borderRadius: BorderRadius.circular(20.0));
      case 1:
        return BoxDecoration(color: AppColors.purpleColor, borderRadius: BorderRadius.circular(20.0));
      case 2:
        return BoxDecoration(color: AppColors.darkThemeColor, borderRadius: BorderRadius.circular(20.0));
      case 3:
        return BoxDecoration(color: AppColors.greenColor, borderRadius: BorderRadius.circular(20.0));
      default:
        return BoxDecoration(color: AppColors.greenColor, borderRadius: BorderRadius.circular(20.0));
    }
  }
}
