import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_taqwa_app/app/controllers/onboarding_controller.dart';
import 'package:flutter_taqwa_app/core/utils/app_colors.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingView extends StatelessWidget {
  final OnboardingController controller = Get.put(OnboardingController());

  OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greenColor,
      body: Stack(
        children: [
          // Arkaplan deseni
          Positioned.fill(child: CustomPaint(painter: _OnboardingBackgroundPainter())),

          // Ana içerik
          Column(
            children: [
              Expanded(
                child: PageView(
                  controller: controller.pageController,
                  onPageChanged: controller.onPageChanged,
                  physics: const ClampingScrollPhysics(),
                  children: [
                    _buildOnboardingPage(
                      context,
                      "assets/svg/mosque.svg",
                      "Namaz Vakitleriniz",
                      "Bulunduğunuz konuma göre tam doğru namaz vakitlerini gösterir",
                    ),
                    _buildOnboardingPage(
                      context,
                      "assets/svg/prayer.svg",
                      "Hatırlatıcılar",
                      "Namaz vakitleri için kişiselleştirilmiş hatırlatıcılar ayarlayın",
                    ),
                    _buildOnboardingPage(
                      context,
                      "assets/svg/quran.svg",
                      "Dini Rehber",
                      "Kur'an-ı Kerim, dualar ve dini bilgiler elinizin altında",
                    ),
                  ],
                ),
              ),

              // Sayfa göstergesi
              Obx(
                () => AnimatedSmoothIndicator(
                  activeIndex: controller.currentPage.value,
                  count: 3,
                  effect: const ExpandingDotsEffect(
                    activeDotColor: AppColors.whiteColor,
                    dotColor: Colors.white54,
                    dotHeight: 8,
                    dotWidth: 8,
                    spacing: 10,
                    expansionFactor: 3,
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // İlerleme butonu
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Obx(() {
                  final isLastPage = controller.currentPage.value == 2;
                  return ElevatedButton(
                    onPressed: () async {
                      if (isLastPage) {
                        controller.completeOnboarding();
                      } else {
                        // Kaydırma animasyonu ile sonraki sayfaya geç
                        await controller.pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                        controller.currentPage.value++;
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.whiteColor,
                      foregroundColor: AppColors.greenColor,
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 0,
                      shadowColor: Colors.transparent,
                    ),
                    child: Text(
                      isLastPage ? "Hemen Başla" : "Sonraki",
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOnboardingPage(BuildContext context, String imagePath, String title, String description) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(imagePath, width: 250, height: 250, color: AppColors.whiteColor),
          const SizedBox(height: 48),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.displaySmall?.copyWith(color: AppColors.whiteColor, fontWeight: FontWeight.bold, height: 1.3),
          ),
          const SizedBox(height: 16),
          Text(
            description,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: AppColors.whiteColor.withOpacity(0.9), height: 1.6),
          ),
        ],
      ),
    );
  }
}

class _OnboardingBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = AppColors.whiteColor.withOpacity(0.05)
          ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(size.width * 0.8, size.height * 0.9), size.width * 0.3, paint);

    canvas.drawCircle(Offset(size.width * 0.2, size.height * 0.1), size.width * 0.2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
