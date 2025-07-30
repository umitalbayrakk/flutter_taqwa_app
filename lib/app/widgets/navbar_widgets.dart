import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_taqwa_app/core/utils/app_colors.dart';
import 'package:flutter_taqwa_app/views/prayer/prayer_view.dart';
import 'package:flutter_taqwa_app/views/religious_information/religious_information.dart';
import 'package:flutter_taqwa_app/views/rosary/rosary_view.dart';
import 'package:get/get.dart';
import 'package:flutter_taqwa_app/app/controllers/navbar_controller.dart';

class CustomNavbarWidgets extends StatelessWidget {
  CustomNavbarWidgets({super.key});

  final NavbarController controller = Get.put(NavbarController());

  final List<Widget> _pages = [
    PrayerView(),
    RosaryView(),
    ReligiousInformation(),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Obx(() => Scaffold(
          body: _pages[controller.selectedIndex.value],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.selectedIndex.value,
            onTap: (index) {
              HapticFeedback.selectionClick();
              controller.changeTab(index);
            },
            backgroundColor: isDark ? AppColors.blackColor : Colors.white,
            selectedItemColor: AppColors.darkThemeColor,
            unselectedItemColor: AppColors.blackColor.withOpacity(0.5),
            showSelectedLabels: true,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                label: "Namaz",
                icon: SvgPicture.asset(
                  "assets/svg/mosque.svg",
                  width: 24,
                  height: 24,
                  color: controller.selectedIndex.value == 0
                      ? AppColors.darkThemeColor
                      : AppColors.blackColor.withOpacity(0.5),
                ),
              ),
              BottomNavigationBarItem(
                label: "Tesbih",
                icon: SvgPicture.asset(
                  "assets/svg/33.svg",
                  width: 24,
                  height: 24,
                  color: controller.selectedIndex.value == 1
                      ? AppColors.darkThemeColor
                      : AppColors.blackColor.withOpacity(0.5),
                ),
              ),
              BottomNavigationBarItem(
                label: "Dini Bilgi",
                icon: SvgPicture.asset(
                  "assets/svg/book.svg",
                  width: 24,
                  height: 24,
                  color: controller.selectedIndex.value == 2
                      ? AppColors.darkThemeColor
                      : AppColors.blackColor.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ));
  }
}
