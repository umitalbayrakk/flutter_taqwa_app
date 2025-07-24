import 'package:flutter/material.dart';
import 'package:flutter_taqwa_app/app/widgets/app_bar_widgets.dart';
import 'package:flutter_taqwa_app/core/utils/app_colors.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBarWidgets(),
      body: Center(child: Column(children: [

          ],
        )),
    );
  }
}
