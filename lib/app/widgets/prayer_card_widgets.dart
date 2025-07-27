import 'package:flutter/material.dart';
import 'package:flutter_taqwa_app/app/controllers/prayer_card_controller.dart';
import 'package:flutter_taqwa_app/core/utils/app_colors.dart';
import 'package:flutter_taqwa_app/views/q%C4%B1blah_finder/q%C4%B1blah_finder.dart';
import 'package:get/get.dart';

class PrayerCardWidgets extends StatelessWidget {
  PrayerCardWidgets({super.key});
  final controller = Get.put(PrayerController());
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 280,
      decoration: BoxDecoration(color: AppColors.greenColor, borderRadius: BorderRadius.circular(20.0)),
      padding: const EdgeInsets.all(16.0),
      child: Obx(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('', style: TextStyle(color: Colors.white, fontSize: 18)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.nextPrayerName.isNotEmpty
                      ? '${controller.nextPrayerName} Vaktine Kalan'
                      : 'Bir Sonraki Vakit',
                  style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      controller.nextPrayerDuration.value != null
                          ? controller.formatDuration(controller.nextPrayerDuration.value!)
                          : '00:00:00',
                      style: const TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.navigateWithSlideTransition(context, const QiblahFinder());
                      },
                      child: Container(
                        height: 40,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.explore, color: AppColors.whiteColor),
                            SizedBox(width: 5),
                            Text(
                              "Kıble Bul",
                              style: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.location_on, color: AppColors.whiteColor),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: controller.navigateAndFetchPrayerTimes,
                      child: Text(
                        controller.selectedPlace.value,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildPrayerTimeBox(context, 'İmsak', controller.todayTimes[0]),
                SizedBox(width: 5),
                _buildPrayerTimeBox(context, 'Güneş', controller.todayTimes[1]),
                SizedBox(width: 5),
                _buildPrayerTimeBox(context, 'Öğle', controller.todayTimes[2]),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildPrayerTimeBox(context, 'İkindi', controller.todayTimes[3]),
                SizedBox(width: 5),
                _buildPrayerTimeBox(context, 'Akşam', controller.todayTimes[4]),
                SizedBox(width: 5),
                _buildPrayerTimeBox(context, 'Yatsı', controller.todayTimes[5]),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrayerTimeBox(BuildContext context, String prayerName, String prayerTime) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.whiteColor.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$prayerName:",
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.whiteColor, fontWeight: FontWeight.bold, fontSize: 14),
            ),
            SizedBox(width: 2),
            Text(
              prayerTime,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.whiteColor, fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
