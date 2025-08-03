
import 'package:flutter/material.dart';
import 'package:flutter_taqwa_app/app/controllers/esmaul_husna_controller.dart';
import 'package:flutter_taqwa_app/app/controllers/hadith_controller.dart';
import 'package:flutter_taqwa_app/app/controllers/theme_controller.dart';
import 'package:flutter_taqwa_app/app/routes/app_pages.dart';
import 'package:flutter_taqwa_app/app/routes/app_routers.dart';
import 'package:flutter_taqwa_app/core/themes/app_themes.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  try {
    await GetStorage.init();
    WidgetsFlutterBinding.ensureInitialized();
    await initializeDateFormatting('tr_TR', null);
    Get.put(EsmaulHusnaController(), permanent: true);
    Get.put(ThemeController(), permanent: true);
    Get.put(HadithController());
  } catch (e) {
    print('Initialization error: $e');
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final box = GetStorage();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    bool isFirstTime = box.read('isFirstTime') ?? true;

    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Taqwa',
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        themeMode: themeController.themeMode.value,
        initialRoute: isFirstTime ? AppRouters.onboarding : AppRouters.customNavbarWidgets,
        getPages: AppPages.routers,
      ),
    );
  }
}
