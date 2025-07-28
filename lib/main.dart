import 'package:flutter/material.dart';
import 'package:flutter_taqwa_app/app/controllers/hadith_controller.dart';
import 'package:flutter_taqwa_app/app/controllers/esmaul_husna_controller.dart';
import 'package:flutter_taqwa_app/app/routes/app_pages.dart';
import 'package:flutter_taqwa_app/app/routes/app_routers.dart';
import 'package:flutter_taqwa_app/views/onboarding/onboarding_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('tr_TR', null);
  Get.put(EsmaulHusnaController(), permanent: true);
  Get.put(HadithController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final box = GetStorage();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    bool isFirstTime = box.read('isFirstTime') ?? true; // Onboarding daha önce gösterilmemisse true
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Taqwa',
      home: OnboardingView(),
      initialRoute: isFirstTime ? AppRouters.onboarding : AppRouters.customNavbarWidgets,
      getPages: AppPages.routers,
    );
  }
}