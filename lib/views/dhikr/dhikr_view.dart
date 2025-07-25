import 'package:flutter/material.dart';
import 'package:flutter_taqwa_app/app/controllers/dhikr_controller.dart';
import 'package:flutter_taqwa_app/core/utils/app_colors.dart';
import 'package:get/get.dart';

class DhikrView extends StatelessWidget {
  const DhikrView({super.key});

  @override
  Widget build(BuildContext context) {
    final DhikrController controller = Get.put(DhikrController());
    final TextEditingController textController = TextEditingController();
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          Column(
            children: [
              const SizedBox(height: 10),
              SizedBox(
                height: 100,
                child: Obx(
                  () => ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.dhikrList.length,
                    itemBuilder: (context, index) {
                      final dhikr = controller.dhikrList[index];
                      final isSelected = controller.selectedDhikr.value == dhikr;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: ChoiceChip(
                          label: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                dhikr,
                                style: TextStyle(
                                  color: isSelected ? AppColors.whiteColor : AppColors.blackColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 4),
                              GestureDetector(
                                onTap: () {
                                  controller.removeDhikr(dhikr);
                                },
                                child: Icon(
                                  Icons.close,
                                  size: 18,
                                  color: isSelected ? AppColors.whiteColor : AppColors.purpleColor,
                                ),
                              ),
                            ],
                          ),
                          selected: isSelected,
                          onSelected: (_) {
                            controller.selectDhikr(dhikr);
                          },
                          selectedColor: AppColors.greenColor,
                          backgroundColor: AppColors.whiteColor,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
            child: TextField(
              controller: textController,
              decoration: InputDecoration(
                hintText: "Yeni zikir ekle",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    if (textController.text.isNotEmpty) {
                      controller.addDhikr(textController.text);
                      textController.clear();
                    }
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => Text(
                      controller.selectedDhikr.value.isEmpty ? "Zikir seçiniz" : controller.selectedDhikr.value,
                      style: Theme.of(
                        context,
                      ).textTheme.headlineMedium?.copyWith(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Obx(
                    () => Text(
                      controller.counter.value.toString(),
                      style: Theme.of(
                        context,
                      ).textTheme.headlineLarge?.copyWith(fontSize: 50, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 50),
                  GestureDetector(
                    onTap: controller.increment,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Container(
                        decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.purpleColor),
                        child: Center(child: Icon(Icons.adjust, size: 200, color: AppColors.whiteColor)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: controller.resetCounter,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.whiteColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                    child: const Text("Sıfırla", style: TextStyle(color: AppColors.blackColor)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
