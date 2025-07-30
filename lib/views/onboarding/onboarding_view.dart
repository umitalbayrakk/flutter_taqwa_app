import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_taqwa_app/app/controllers/onboarding_controller.dart';
import 'package:flutter_taqwa_app/core/utils/app_colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingView extends StatelessWidget {
  final OnboardingController controller = Get.put(OnboardingController());

  final List<IconData> icons = const [Icons.location_on_outlined, Icons.widgets_outlined, Icons.book_outlined];

  OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Gradient Background
          Obx(
            () => AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: _getPageGradient(controller.currentPage.value),
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          // Page Content
          PageView.builder(
            controller: controller.pageController,
            itemCount: controller.pages.length,
            onPageChanged: (index) {
              print('Page changed to: $index');
              controller.onPageChanged(index);
            },
            physics: const ClampingScrollPhysics(),
            itemBuilder: (context, index) {
              if (index >= controller.pages.length) {
                return const SizedBox(); // Prevent index out of bounds
              }
              final page = controller.pages[index];
              return Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    const Spacer(flex: 2),
                    // Icon Container
                    AnimatedOpacity(
                      opacity: controller.currentPage.value == index ? 1.0 : 0.5,
                      duration: const Duration(milliseconds: 500),
                      child: Container(
                        height: size.width * 0.4,
                        width: size.width * 0.4,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.whiteColor.withOpacity(0.1),
                          border: Border.all(color: AppColors.whiteColor.withOpacity(0.24), width: 1),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20, spreadRadius: 2)],
                        ),
                        child: Center(child: Icon(icons[index], size: size.width * 0.2, color: AppColors.whiteColor)),
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Title
                    AnimatedSlide(
                      offset: controller.currentPage.value == index ? Offset.zero : const Offset(0, 0.2),
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeOut,
                      child: Text(
                        page.title,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppColors.whiteColor,
                        ),
                        semanticsLabel: page.title,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Description
                    AnimatedSlide(
                      offset: controller.currentPage.value == index ? Offset.zero : const Offset(0, 0.2),
                      duration: const Duration(milliseconds: 700),
                      curve: Curves.easeOut,
                      child: Text(
                        page.description,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: AppColors.whiteColor.withOpacity(0.7),
                          height: 1.6,
                        ),
                        semanticsLabel: page.description,
                      ),
                    ),
                    const Spacer(flex: 3),
                  ],
                ),
              );
            },
          ),
          // Bottom Controls
          Positioned(
            bottom: 40,
            left: 24,
            right: 24,
            child: Column(
              children: [
                // Page Indicators
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(controller.pages.length, (index) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: controller.currentPage.value == index ? 20 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color:
                              controller.currentPage.value == index
                                  ? AppColors.whiteColor
                                  : AppColors.whiteColor.withOpacity(0.38),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 24),
                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Skip Button
                    Obx(
                      () =>
                          controller.currentPage.value != controller.pages.length - 1
                              ? TextButton(
                                onPressed: () {
                                  print('Skip button pressed');
                                  HapticFeedback.lightImpact();
                                  controller.completeOnboarding();
                                },
                                child: Text(
                                  'Atla',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: AppColors.whiteColor.withOpacity(0.8),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                              : const SizedBox(),
                    ),
                    // Next/Start Button
                    Obx(
                      () => SizedBox(
                        width: 150,
                        child: ElevatedButton(
                          onPressed: () {
                            try {
                              print(
                                'Next button pressed, currentPage: ${controller.currentPage.value}, hasClients: ${controller.pageController.hasClients}',
                              );
                              HapticFeedback.lightImpact();
                              if (!controller.pageController.hasClients) {
                                print('PageController not ready');
                                Get.snackbar('Hata', 'Sayfa kontrolcüsü hazır değil, lütfen tekrar deneyin.');
                                return;
                              }
                              if (controller.currentPage.value == controller.pages.length - 1) {
                                controller.completeOnboarding();
                              } else {
                                controller.pageController.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOutCubic,
                                );
                                print('Next page triggered');
                              }
                            } catch (e, stackTrace) {
                              print('Error in Next button: $e');
                              print('StackTrace: $stackTrace');
                              Get.snackbar('Hata', 'Sayfa geçişi başarısız: $e');
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.whiteColor,
                            foregroundColor: AppColors.greenColor,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            textStyle: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          child: Text(
                            controller.currentPage.value == controller.pages.length - 1 ? 'Hemen Başla' : 'Sonraki',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Color> _getPageGradient(int index) {
    const gradients = [
      [Color(0xFF1B5E20), Color(0xFF4CAF50)],
      [Color(0xFF2E7D32), Color(0xFF81C784)],
      [Color(0xFF388E3C), Color(0xFFA5D6A7)],
    ];
    return gradients[index % gradients.length];
  }
}
