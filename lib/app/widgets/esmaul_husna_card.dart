import 'package:flutter/material.dart';
import 'package:flutter_taqwa_app/app/controllers/esmaul_husna_controller.dart';
import 'package:flutter_taqwa_app/core/utils/app_colors.dart';
import 'package:get/get.dart';

class EsmaulHusnaCardWidget extends StatelessWidget {
  const EsmaulHusnaCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final EsmaulHusnaController controller = Get.find<EsmaulHusnaController>();
    return Obx(
      () => Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: BorderRadius.circular(12.0)),
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
                        controller.esmaulHusna.value?.arapca ?? '',
                        style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        controller.esmaulHusna.value?.okunusu ?? '',
                        style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.black87),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        controller.esmaulHusna.value?.anlami ?? '',
                        style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.black87),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
        ),
      ),
    );
  }
}
