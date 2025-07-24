import 'package:flutter/material.dart';
import 'package:flutter_taqwa_app/app/controllers/dhikr_controller.dart';
import 'package:flutter_taqwa_app/core/utils/app_colors.dart';
import 'package:get/get.dart';

class DhikrView extends StatelessWidget {
  const DhikrView({super.key});

  @override
  Widget build(BuildContext context) {
    final DhikrController controller = Get.put(DhikrController());
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => Text(
                controller.counter.value.toString(),
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 50, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 50),
            GestureDetector(
              onTap: controller.increment,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    color: AppColors.greenColor,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.adjust, size: 43, color: AppColors.whiteColor),
                        SizedBox(width: 10),
                        Text(
                          "Tıkla",
                          style: Theme.of(
                            context,
                          ).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold, color: AppColors.whiteColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
