import 'package:flutter/material.dart';
import 'package:flutter_taqwa_app/app/controllers/hadith_controller.dart';
import 'package:flutter_taqwa_app/app/widgets/navbar_widgets.dart';
import 'package:flutter_taqwa_app/app/controllers/esmaul_husna_controller.dart';
import 'package:get/get.dart';

void main() {
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
