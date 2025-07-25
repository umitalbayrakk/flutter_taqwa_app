import 'package:flutter/material.dart';
import 'package:flutter_taqwa_app/app/controllers/dhikr_controller.dart';
import 'package:flutter_taqwa_app/app/controllers/hadith_controller.dart';
import 'package:flutter_taqwa_app/app/widgets/navbar_widgets.dart';
import 'package:flutter_taqwa_app/app/controllers/esmaul_husna_controller.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('tr_TR', null); // Türkçe locale başlatma
  Get.put(EsmaulHusnaController(), permanent: true);
  Get.put(HadithController());
  Get.put(DhikrController()); // Burada bir kere tanımla

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Taqwa',
      //routes:
      home: CustomNavbarWidgets(),
    );
  }
}
