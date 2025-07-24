import 'package:flutter/material.dart';
import 'package:flutter_taqwa_app/core/utils/app_colors.dart';

class AppBarWidgets extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidgets({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(50.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.whiteColor,
      centerTitle: true,
      elevation: 0,
      title: Text("Taqwa", style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold)),
    );
  }
}
