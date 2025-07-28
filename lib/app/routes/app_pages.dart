import 'package:flutter_taqwa_app/app/routes/app_routers.dart';
import 'package:flutter_taqwa_app/app/widgets/navbar_widgets.dart';
import 'package:flutter_taqwa_app/views/onboarding/onboarding_view.dart';
import 'package:flutter_taqwa_app/views/q%C4%B1blah_finder/q%C4%B1blah_finder.dart';
import 'package:flutter_taqwa_app/views/religious_information/religious_information.dart';
import 'package:flutter_taqwa_app/views/rosary/rosary_view.dart';
import 'package:flutter_taqwa_app/views/settings/settings_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppPages {
  static final routers = [
    GetPage(name: AppRouters.onboarding, page: () => OnboardingView()),
    GetPage(name: AppRouters.customNavbarWidgets, page: () => CustomNavbarWidgets()),
    GetPage(name: AppRouters.drawerMenu, page: () => SettingsView()),
    GetPage(name: AppRouters.qibleFinder, page: () => QiblahFinder()),
    GetPage(name: AppRouters.rosary, page: () => RosaryView()),
    GetPage(name: AppRouters.religiousInformation, page: () => ReligiousInformation()),
  ];
}
