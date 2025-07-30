import 'package:flutter/material.dart';
import 'package:flutter_taqwa_app/app/widgets/app_bar_widgets.dart';
import 'package:flutter_taqwa_app/core/utils/app_colors.dart';

class QiblahFinder extends StatelessWidget {
  const QiblahFinder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidgets(showBackButton: true),
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Center(child: Text("Konum Açılışı", style: TextStyle(fontSize: 20))),
              const SizedBox(height: 15),
              const SizedBox(height: 20),
              const Text(
                "Not: Manyetik alanlar ve manyetik olabilcek\nkılıflar sonucu yanıltabilir.",
                style: TextStyle(fontSize: 13),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
