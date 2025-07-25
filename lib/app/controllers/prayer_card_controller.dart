import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter_taqwa_app/views/prayer_selected_time/prayer_time_view.dart';

class PrayerController extends GetxController {
  var selectedPlace = 'Beşiktaş / İstanbul'.obs;
  var todayTimes = ['00:00', '00:00', '00:00', '00:00', '00:00', '00:00'].obs;

  var nextPrayerName = ''.obs;
  var nextPrayerDuration = Rxn<Duration>();

  Timer? _timer;

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
}
