import 'package:flutter/material.dart';
import 'package:flutter_taqwa_app/app/controllers/app_bar_controller.dart';
import 'package:flutter_taqwa_app/app/controllers/prayer_card_controller.dart';
import 'package:flutter_taqwa_app/core/utils/app_colors.dart';
import 'package:flutter_taqwa_app/views/prayer_selected_time/prayer_time_view.dart';
import 'package:flutter_taqwa_app/views/qazaprayer_calculator/qazaprayer_calculator_view.dart';
import 'package:get/get.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final cardController = Get.put(PrayerController());
    final AppBarController controller = Get.put(AppBarController());
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: Text("Ayarlar", style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        children: [
          _buildSectionTitle("Hesap"),
          _buildTile(icon: Icons.lock_outline, title: "Gizlilik", onTap: () {}),
          _buildTile(icon: Icons.feedback, title: "Geri Bildirim", onTap: () {}),

          _buildTile(icon: Icons.notifications_none, title: "Bildirimler", onTap: () {}),
          const SizedBox(height: 16),
          _buildSectionTitle("Uygulama"),
          _buildTile(
            icon: Icons.brightness_6,
            title: "Tema",
            trailingText: isDark ? "Karanlık" : "Aydınlık",
            onTap: () {},
          ),
          _buildTile(
            icon: Icons.location_on,
            title: "Konum Seç",
            onTap: () {
              controller.navigateWithSlideTransition(context, const PrayerTimesScreen());
              cardController.navigateAndFetchPrayerTimes();
            },
          ),
          _buildTile(
            icon: Icons.timer,
            title: "Kaza Namazı Hesapla",
            onTap: () {
              controller.navigateWithSlideTransition(context, KazaView());
            },
          ),
          _buildTile(
            icon: Icons.color_lens,
            title: "Arka Plan Rengi",
            onTap: () {
              _showBackgroundColorDialog(context, cardController);
            },
          ),
          _buildTile(icon: Icons.info_outline, title: "Hakkımızda", onTap: () {}),
          _buildTile(icon: Icons.star_border, title: "Puanla", onTap: () {}),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 0.8),
      ),
    );
  }

  Widget _buildTile({
    required IconData icon,
    required String title,
    String? trailingText,
    VoidCallback? onTap,
    Color? iconColor,
    Color? textColor,
  }) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          dense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          leading: Icon(icon, color: iconColor ?? Colors.black, size: 20),
          title: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: textColor ?? Colors.black),
          ),
          trailing:
              trailingText != null
                  ? Text(trailingText, style: const TextStyle(color: Colors.grey, fontSize: 13))
                  : const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
        ),
        const Divider(height: 0.5),
      ],
    );
  }

  void _showBackgroundColorDialog(BuildContext context, PrayerController cardController) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.whiteColor,
          title: const Text("Namaz Vakitleri Arka Plan Rengini Seçin"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildColorOption(context, cardController, 0, AppColors.orangeColor),
                _buildColorOption(context, cardController, 1, AppColors.purpleColor),
                _buildColorOption(context, cardController, 2, AppColors.darkThemeColor),
                _buildColorOption(context, cardController, 3, AppColors.greenColor),
              ],
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(backgroundColor: AppColors.redColor),
              onPressed: () => Navigator.pop(context),
              child: Text(
                "İptal",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.whiteColor),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildColorOption(BuildContext context, PrayerController controller, int index, Color color) {
    return Obx(
      () => ListTile(
        leading: Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.rectangle,
            border: Border.all(
              color: controller.selectedBackgroundIndex.value == index ? Colors.black : Colors.grey,
              width: 2,
            ),
          ),
        ),
        onTap: () {
          controller.changeBackground(index);
          Navigator.pop(context);
        },
      ),
    );
  }
}
