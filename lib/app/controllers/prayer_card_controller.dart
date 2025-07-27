import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_taqwa_app/views/prayer_selected_time/prayer_time_view.dart';

class PrayerController extends GetxController {
  final GetStorage _storage = GetStorage();

  var selectedPlace = 'Beşiktaş / İstanbul'.obs;
  var todayTimes = ['00:00', '00:00', '00:00', '00:00', '00:00', '00:00'].obs;

  var nextPrayerName = ''.obs;
  var nextPrayerDuration = Rxn<Duration>();

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();

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

    // Kalıcı olarak kaydet
    _storage.write('selected_place', place);
    _storage.write('today_times', timesList);

    _calculateNextPrayerTime();
    _startTimer();
  }

  void _calculateNextPrayerTime() {
    if (todayTimes.contains('--:--')) {
      nextPrayerDuration.value = null;
      nextPrayerName.value = '';
      return;
    }

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final prayerNames = ['İmsak', 'Güneş', 'Öğle', 'İkindi', 'Akşam', 'Yatsı'];

    for (var i = 0; i < todayTimes.length; i++) {
      final parts = todayTimes[i].split(':');
      final prayerTime = DateTime(today.year, today.month, today.day, int.parse(parts[0]), int.parse(parts[1]));
      if (prayerTime.isAfter(now)) {
        nextPrayerDuration.value = prayerTime.difference(now);
        nextPrayerName.value = prayerNames[i];
        return;
      }
    }

    final parts = todayTimes[0].split(':');
    final nextImsak = today
        .add(const Duration(days: 1))
        .copyWith(hour: int.parse(parts[0]), minute: int.parse(parts[1]));

    nextPrayerDuration.value = nextImsak.difference(now);
    nextPrayerName.value = 'İmsak';
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _calculateNextPrayerTime();
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
