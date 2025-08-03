import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_taqwa_app/app/widgets/navbar_widgets.dart';
import 'package:flutter_taqwa_app/core/utils/app_colors.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    return Scaffold(
      body: IntroductionScreen(
        globalBackgroundColor: Theme.of(context).cardTheme.color,
        scrollPhysics: BouncingScrollPhysics(),
        pages: [
          PageViewModel(
            titleWidget: Text(
              textAlign: TextAlign.center,
              "Seçtiğiniz Konuma Göre Namaz Vakitleri",
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            body: "Manuel olarak belirlediğiniz konuma göre namaz vakitleri görüntülenir.",
            image: Icon(FeatherIcons.map, size: 200, color: AppColors.greenColor),
          ),
          PageViewModel(
            titleWidget: Text(
              "Kıble Bulma Aracı",
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            body: "Telefonunuzdan konumuna göre otomatik olarak kıble bulma aracını kullanabilirsiniz.",
            image: Icon(FeatherIcons.compass, size: 200, color: AppColors.greenColor),
          ),
          PageViewModel(
            titleWidget: Text(
              "Etkileşimli Widgetlar",
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            body: "Namaz Ve Ramazan Kartları ve dahası ayet ve esmul hüsna bu uygulamada",
            image: Icon(FeatherIcons.grid, size: 200, color: AppColors.greenColor),
          ),
        ],
        next: Icon(FeatherIcons.arrowRight, color: AppColors.greenBlackColor, size: 20),
        onDone: () {
          box.write('isFirstTime', false);
          Get.off(() => CustomNavbarWidgets());
        },
        onSkip: () {
          box.write('isFirstTime', false);
          Get.off(() => CustomNavbarWidgets());
        },
        showSkipButton: true,
        skip: Text("Atla", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.greenColor)),
        done: Text("Haydi Başla", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.greenColor)),
        dotsDecorator: DotsDecorator(
          size: Size.square(10.0),
          activeSize: Size(20.0, 10.0),
          color: Theme.of(context).iconTheme.color ?? Colors.black,
          activeColor: AppColors.greenColor,
          spacing: EdgeInsets.symmetric(horizontal: 3.0),
          activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        ),
      ),
    );
  }
}
