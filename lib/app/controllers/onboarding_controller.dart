import 'package:flutter/material.dart';
import 'package:flutter_taqwa_app/app/routes/app_routers.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OnboardingController extends GetxController {
  final box = GetStorage();
  final currentPage = 0.obs;
  final PageController pageController = PageController();

  @override
  void onInit() {
    super.onInit();
    // İlk açılışta kaydırma animasyonu ekleyebiliriz
    Future.delayed(const Duration(milliseconds: 300), () {
      pageController.animateToPage(
        currentPage.value,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  // Sayfa değiştiğinde çağrılacak fonksiyon
  void onPageChanged(int index) {
    currentPage.value = index;
  }

  // Sonraki sayfaya geç
  void nextPage() {
    if (currentPage.value < 2) {
      // 3 sayfa olduğunu varsayarsak (0,1,2)
      currentPage.value++;
      pageController.animateToPage(
        currentPage.value,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutQuint,
      );
    } else {
      completeOnboarding();
    }
  }

  // Onboarding tamamlandı
  void completeOnboarding() {
    box.write('isFirstTime', false);
    Get.offAllNamed(AppRouters.customNavbarWidgets);
    // İsteğe bağlı: Firebase Analytics veya başka bir analiz aracına kayıt
    // logOnboardingCompletion();
  }

  // İsteğe bağlı: Onboarding tamamlanma analitiği
  // Future<void> logOnboardingCompletion() async {
  //   await AnalyticsService.logEvent('onboarding_completed');
  // }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
