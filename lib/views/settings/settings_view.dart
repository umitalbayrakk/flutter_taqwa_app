import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_taqwa_app/app/controllers/app_bar_controller.dart';
import 'package:flutter_taqwa_app/app/controllers/prayer_card_controller.dart';
import 'package:flutter_taqwa_app/app/controllers/theme_controller.dart';
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
    final ThemeController themeController = Get.find<ThemeController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text("Ayarlar", style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        children: [
          _buildSectionTitle("Hesap"),
          _buildTile(context: context, icon: Icons.lock_outline, title: "Gizlilik", onTap: () {}),
          _buildTile(context: context, icon: Icons.feedback, title: "Geri Bildirim", onTap: () {}),
          _buildTile(context: context, icon: Icons.notifications_none, title: "Bildirimler", onTap: () {}),
          const SizedBox(height: 16),
          _buildSectionTitle("Uygulama"),
          ThemeToggleButton(),
          _buildTile(
            context: context,
            icon: Icons.location_on,
            title: "Konum Seç",
            onTap: () {
              controller.navigateWithSlideTransition(context, const PrayerTimesScreen());
              cardController.navigateAndFetchPrayerTimes();
            },
          ),
          _buildTile(
            context: context,
            icon: Icons.timer,
            title: "Kaza Namazı Hesapla",
            onTap: () {
              controller.navigateWithSlideTransition(context, KazaView());
            },
          ),
          _buildTile(
            context: context,
            icon: Icons.color_lens,
            title: "Arka Plan Rengi",
            onTap: () {
              _showBackgroundColorDialog(context, cardController);
            },
          ),
          _buildTile(context: context, icon: Icons.info_outline, title: "Hakkımızda", onTap: () {}),
          _buildTile(context: context, icon: Icons.star_border, title: "Puanla", onTap: () {}),
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
    required BuildContext context,
    required IconData icon,
    required String title,
    String? trailingText,
    VoidCallback? onTap,
    Color? textColor,
  }) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          dense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          leading: Icon(icon, color: Theme.of(context).iconTheme.color, size: 20),
          title: Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: textColor),
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
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          minLeadingWidth: 0,
          onTap: () => _showThemeBottomSheet(context),
          dense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          leading: Icon(Icons.color_lens, color: Theme.of(context).iconTheme.color, size: 20),
          title: Text(
            "Tema Seçimi",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
        ),
        const Divider(height: 0.5),
      ],
    );
  }

  void _showThemeBottomSheet(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (_) {
        return Obx(() {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              const Text('Tema Seçimi', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const Divider(),
              _buildOption(
                icon: FeatherIcons.sun,
                label: 'Aydınlık Tema',
                selected: themeController.themeMode.value == ThemeMode.light,
                onTap: () {
                  themeController.setTheme(ThemeMode.light);
                  Get.back();
                },
              ),
              _buildOption(
                icon: FeatherIcons.moon,
                label: 'Karanlık Tema',
                selected: themeController.themeMode.value == ThemeMode.dark,
                onTap: () {
                  themeController.setTheme(ThemeMode.dark);
                  Get.back();
                },
              ),
              _buildOption(
                icon: FeatherIcons.aperture,
                label: 'Sistem Teması',
                selected: themeController.themeMode.value == ThemeMode.system,
                onTap: () {
                  themeController.setTheme(ThemeMode.system);
                  Get.back();
                },
              ),
              const SizedBox(height: 16),
            ],
          );
        });
      },
    );
  }

  Widget _buildOption({
    required IconData icon,
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      trailing: selected ? const Icon(Icons.check, color: Colors.blue) : null,
      onTap: onTap,
    );
  }
}
