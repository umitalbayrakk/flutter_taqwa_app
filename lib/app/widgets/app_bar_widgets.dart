import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_taqwa_app/app/controllers/app_bar_controller.dart';
import 'package:flutter_taqwa_app/views/settings/settings_view.dart';
import 'package:get/get.dart';

class AppBarWidgets extends StatelessWidget implements PreferredSizeWidget {
  final bool showBackButton;

  const AppBarWidgets({super.key, this.showBackButton = true});

  @override
  Size get preferredSize => const Size.fromHeight(80.0);

  @override
  Widget build(BuildContext context) {
    final AppBarController controller = Get.put(AppBarController());

    return AppBar(
      automaticallyImplyLeading: showBackButton,
      actions: [
        IconButton(
          icon: SvgPicture.asset(
            "assets/svg/menu.svg",
            color: Theme.of(context).iconTheme.color,
            width: 30,
            height: 30,
          ),
          onPressed: () {
            controller.navigateWithSlideTransition(context, const SettingsView());
          },
        ),
      ],
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      centerTitle: false,
      title: Image.asset("assets/images/logo2.png", width: 80, height: 80, color: Theme.of(context).iconTheme.color),
    );
  }
}
