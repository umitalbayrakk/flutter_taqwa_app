import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_taqwa_app/app/widgets/app_bar_widgets.dart';
import 'package:piri_qiblah/piri_qiblah.dart';

class QiblahFinder extends StatelessWidget {
  const QiblahFinder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidgets(showBackButton: true),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 15),
              Center(
                child: PiriQiblah(
                  compassSize: 300,
                  angleTextStyle: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontSize: 50, fontWeight: FontWeight.bold),
                  useDefaultAssets: true,
                  //customBackgroundCompass: SvgPicture.asset("assets/svg/compass.svg"),
                  //customNeedle: SvgPicture.asset("assets/svg/needle.svg"),
                  customPermissionDeniedMessage: 'Konum İzni Verilmedi',
                  customLoadingIndicator: const CircularProgressIndicator(),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Not: Manyetik alanlar ve manyetik olabilcek\nkılıflar sonucu yanıltabilir.",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
