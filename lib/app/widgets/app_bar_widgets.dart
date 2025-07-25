import 'package:flutter/material.dart';
import 'package:flutter_taqwa_app/app/controllers/app_bar_controller.dart';
import 'package:flutter_taqwa_app/core/utils/app_colors.dart';
import 'package:flutter_taqwa_app/views/settings/settings_view.dart';
import 'package:get/get.dart';

class AppBarWidgets extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidgets({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(80.0); // Biraz daha yüksek

  @override
  Widget build(BuildContext context) {
    final AppBarController controller = Get.put(AppBarController());

    return AppBar(
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 6.0, offset: const Offset(0, 3)),
                ],
              ),
              child: const Icon(Icons.menu_rounded, size: 24),
            ),
            onPressed: () {
              controller.navigateWithSlideTransition(context, const SettingsView());
            },
          ),
        ),
      ],
      backgroundColor: AppColors.whiteColor,
      centerTitle: true,
      elevation: 0,
      title: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "Taq",
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.tagColor, 
              ),
            ),
            TextSpan(
              text: "wa",
              style: Theme.of(
                context,
              ).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ],
        ),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(15),
        ),
      ),
    );
  }
}
