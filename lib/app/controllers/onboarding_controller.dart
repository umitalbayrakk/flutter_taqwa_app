import 'package:flutter/material.dart';
import 'package:flutter_taqwa_app/app/models/prayer_check_model/prayer_check_model.dart';
import 'package:flutter_taqwa_app/app/routes/app_routers.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OnboardingController extends GetxController {
  final box = GetStorage();
  final currentPage = 0.obs;
  late final PageController pageController;

  final List<OnboardingModel> pages = [
    OnboardingModel(
      title: 'Konum Seçimi',
      description: 'İstediğiniz konumlarda manuel olarak namaz vakitlerini bulun',
      imageUrl: '',
    ),
    OnboardingModel(
      title: 'Widgetlar',
      description: 'Namaz vakitleri için kişiselleştirilmiş hatırlatıcılar ayarlayın',
      imageUrl: '',
    ),
    OnboardingModel(
      title: 'Dini Rehber',
      description: 'Kur\'an-ı Kerim, dualar ve dini bilgiler elinizin altında',
      imageUrl: '',
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    // Initialize a new PageController for this instance
    pageController = PageController();
    // Smooth start animation
    Future.delayed(const Duration(milliseconds: 300), () {
      if (pageController.hasClients) {
        pageController.animateToPage(
          currentPage.value,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  // Handle page change
  void onPageChanged(int index) {
    currentPage.value = index;
  }

  // Complete onboarding and navigate to main app
  void completeOnboarding() {
    box.write('isFirstTime', false);
    Get.offAllNamed(AppRouters.customNavbarWidgets);
  }

  @override
  void onClose() {
    pageController.dispose(); // Ensure the controller is disposed
    super.onClose();
  }
}
