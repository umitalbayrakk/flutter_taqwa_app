import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_taqwa_app/app/controllers/navbar_controller.dart';
import 'package:flutter_taqwa_app/app/widgets/app_bar_widgets.dart';
import 'package:flutter_taqwa_app/core/utils/app_colors.dart';
import 'package:flutter_taqwa_app/views/dhikr/dhikr_view.dart';
import 'package:flutter_taqwa_app/views/prayer/prayer_view.dart';
import 'package:flutter_taqwa_app/views/qıblah_finder/qıblah_finder.dart';
import 'package:get/get.dart';

class CustomNavbarWidgets extends StatefulWidget {
  const CustomNavbarWidgets({super.key});

  @override
  State<CustomNavbarWidgets> createState() => _CustomNavbarWidgetsState();
}

class _CustomNavbarWidgetsState extends State<CustomNavbarWidgets> {
  final NavbarController controller = Get.put(NavbarController());

  final List<Widget> _pages = const [PrayerView(), DhikrView(), QiblahFinder()];

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBarWidgets(),
      extendBody: true,
      body: Obx(() => _pages[controller.selectedIndex.value]),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Obx(
            () => Container(
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 3)),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(3, (index) {
                  final bool isSelected = controller.selectedIndex.value == index;
                  IconData iconData;
                  String label;

                  switch (index) {
                    case 0:
                      iconData = Icons.mosque_rounded;
                      label = 'Namaz';
                      break;
                    case 1:
                      iconData = Icons.adjust;
                      label = 'Tesbih';
                      break;
                    case 2:
                    default:
                      iconData = Icons.explore;
                      label = 'Kıble';
                      break;
                  }

                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        HapticFeedback.selectionClick();
                        controller.changeIndex(index);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.greenColor : Colors.transparent,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Center(
                          child: AnimatedScale(
                            scale: isSelected ? 1.1 : 1.0,
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeInOut,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AnimatedOpacity(
                                  opacity: isSelected ? 1.0 : 0.6,
                                  duration: const Duration(milliseconds: 250),
                                  child: Icon(
                                    iconData,
                                    size: 22,
                                    color: isSelected ? AppColors.whiteColor : Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                AnimatedDefaultTextStyle(
                                  duration: const Duration(milliseconds: 250),
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                    color: isSelected ? AppColors.whiteColor : Colors.grey,
                                  ),
                                  child: Text(label),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
