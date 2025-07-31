import 'package:flutter/material.dart';
import 'package:flutter_taqwa_app/app/widgets/app_bar_widgets.dart';
import 'package:flutter_taqwa_app/app/widgets/esmaul_husna_card.dart';
import 'package:flutter_taqwa_app/app/widgets/hadith_card_widgets.dart';
import 'package:flutter_taqwa_app/app/widgets/prayer_card_widgets.dart';
import 'package:flutter_taqwa_app/core/utils/app_colors.dart';

class PrayerView extends StatefulWidget {
  const PrayerView({super.key});

  @override
  State<PrayerView> createState() => _PrayerViewState();
}

class _PrayerViewState extends State<PrayerView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidgets(showBackButton: false),
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child: Column(
            children: [
              SizedBox(height: 20),
              PrayerCardWidgets(),
              SizedBox(height: 20),
              EsmaulHusnaCardWidget(),
              SizedBox(height: 20),
              HadithCardWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
