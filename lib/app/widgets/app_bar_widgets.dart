import 'package:flutter/material.dart';
import 'package:flutter_taqwa_app/app/controllers/app_bar_controller.dart';
import 'package:flutter_taqwa_app/core/utils/app_colors.dart';
import 'package:flutter_taqwa_app/views/settings/settings_view.dart';
import 'package:get/get.dart';

class AppBarWidgets extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidgets({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(80.0);

  @override
  Widget build(BuildContext context) {
    final AppBarController controller = Get.put(AppBarController());

    return AppBar(
      automaticallyImplyLeading: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.menu_rounded, size: 24),
          onPressed: () {
            controller.navigateWithSlideTransition(context, const SettingsView());
          },
        ),
      ],
      backgroundColor: AppColors.whiteColor,
      centerTitle: false,
      elevation: 0,
      title: Image.asset("assets/images/logo2.png", width: 80, height: 80),
    );
  }
}
