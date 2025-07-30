import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_taqwa_app/app/controllers/prayer_card_controller.dart';
import 'package:flutter_taqwa_app/core/utils/app_colors.dart';
import 'package:flutter_taqwa_app/views/q%C4%B1blah_finder/q%C4%B1blah_finder.dart';
import 'package:get/get.dart';

class PrayerCardWidgets extends StatelessWidget {
  PrayerCardWidgets({super.key});

  final controller = Get.put(PrayerController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: controller.getBackground(controller.selectedBackgroundIndex.value),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tarihler ve Sayaç
            Text(
              controller.formattedHijriDate.value,
              style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              controller.nextPrayerName.isNotEmpty ? '${controller.nextPrayerName} Vaktine Kalan' : 'Bir Sonraki Vakit',
              style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              controller.nextPrayerDuration.value != null
                  ? controller.formatDuration(controller.nextPrayerDuration.value!)
                  : '00:00:00',
              style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // Lokasyon
            Row(
              children: [
                SvgPicture.asset("assets/svg/map-pin.svg"),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: controller.navigateAndFetchPrayerTimes,
                  child: Text(
                    controller.selectedPlace.value,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Namaz Vakitleri
            Column(
              children: List.generate(6, (index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Obx(() {
                    final isCurrent = controller.currentPrayerSlotIndex.value == index;
                    return _buildPrayerTimeBox(
                      context,
                      controller.prayerNames[index],
                      controller.todayTimes[index],
                      "assets/svg/${controller.getIconFileName(index)}.svg",
                      isCurrent,
                    );
                  }),
                );
              }),
            ),
            const SizedBox(height: 10),
            // Kıble Butonu
            GestureDetector(
              onTap: () => controller.navigateWithSlideTransition(context, const QiblahFinder()),
              child: Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/svg/compass.svg", width: 20, height: 20, color: AppColors.blackColor),
                    const SizedBox(width: 5),
                    Text(
                      "Kıble Bul",
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: AppColors.blackColor, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            /* GestureDetector(
              onTap: () => controller.navigateWithSlideTransition(context, KazaView()),
              child: Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.calculate, color: AppColors.blackColor, size: 20),
                    const SizedBox(width: 5),
                    Text(
                      "Kaza Takibi",
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: AppColors.blackColor, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            */
          ],
        ),
      ),
    );
  }

  /// Namaz Vakti Kutusu
  Widget _buildPrayerTimeBox(
    BuildContext context,
    String prayerName,
    String prayerTime,
    String svgAssetPath,
    bool isCurrent,
  ) {
    final Color backgroundColor = isCurrent ? AppColors.selectedPrayerColor.withOpacity(0.3) : Colors.transparent;
    final Color textColor = isCurrent ? AppColors.whiteColor : AppColors.whiteColor;
    final Color iconColor = isCurrent ? AppColors.whiteColor : AppColors.whiteColor;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: AppColors.whiteColor.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const SizedBox(width: 10),
          SvgPicture.asset(
            svgAssetPath,
            width: 20,
            height: 20,
            colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
          ),
          const SizedBox(width: 5),
          Text(
            "$prayerName:",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: textColor, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 2),
          Text(
            prayerTime,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: textColor, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
