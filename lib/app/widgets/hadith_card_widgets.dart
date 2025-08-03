import 'package:flutter/material.dart';
import 'package:flutter_taqwa_app/core/utils/app_colors.dart';
import 'package:get/get.dart';
import '../controllers/hadith_controller.dart';

class HadithCardWidget extends StatelessWidget {
  const HadithCardWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final HadithController controller = Get.find<HadithController>();
    return Obx(
      () => Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(color: Theme.of(context).cardTheme.color, borderRadius: BorderRadius.circular(12.0)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '- ${controller.hadith.value?.ravi ?? ''}',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).textTheme.headlineSmall!.color,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        controller.hadith.value?.metin ?? '',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).textTheme.headlineSmall!.color,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            controller.hadith.value?.kaynak ?? '',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).textTheme.headlineSmall!.color,
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Text(
                            '(${controller.hadith.value?.hadisNo ?? ''})',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).textTheme.headlineSmall!.color,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
        ),
      ),
    );
  }
}
