import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_taqwa_app/app/controllers/religious_info_controller.dart';
import 'package:flutter_taqwa_app/app/widgets/app_bar_widgets.dart';
import 'package:flutter_taqwa_app/core/utils/app_colors.dart';

class ReligiousInformation extends StatelessWidget {
  const ReligiousInformation({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReligiousInfoController());

    return Scaffold(
      appBar: AppBarWidgets(showBackButton: false),
      backgroundColor: AppColors.backgroundColor,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final info = controller.religiousInfo.value;

        if (info == null) {
          return const Center(child: Text("Veri bulunamadı."));
        }

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text("İmanın Şartları", style: Theme.of(context).textTheme.titleLarge),
            ...info.imanSartlari.map((e) => ListTile(leading: const Icon(Icons.check_circle_outline), title: Text(e))),
            const SizedBox(height: 20),
            Text("İslam'ın Şartları", style: Theme.of(context).textTheme.titleLarge),
            ...info.islamSartlari.map((e) => ListTile(leading: const Icon(Icons.star_border), title: Text(e))),
          ],
        );
      }),
    );
  }
}
