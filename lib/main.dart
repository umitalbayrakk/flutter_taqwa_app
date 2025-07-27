import 'package:flutter/material.dart';
import 'package:flutter_taqwa_app/app/controllers/hadith_controller.dart';
import 'package:flutter_taqwa_app/app/widgets/navbar_widgets.dart';
import 'package:flutter_taqwa_app/app/controllers/esmaul_husna_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await GetStorage.init(); // bu şart
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('tr_TR', null); // Türkçe locale başlatma
  Get.put(EsmaulHusnaController(), permanent: true);
  Get.put(HadithController());

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
