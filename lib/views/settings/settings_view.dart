import 'package:flutter/material.dart';
import 'package:flutter_taqwa_app/app/controllers/app_bar_controller.dart';
import 'package:flutter_taqwa_app/core/utils/app_colors.dart';
import 'package:flutter_taqwa_app/views/prayer_selected_time/prayer_time_view.dart';
import 'package:get/get.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final AppBarController controller = Get.put(AppBarController());
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(title: const Text("Ayarlar"), centerTitle: true, elevation: 0),
      backgroundColor: AppColors.backgroundColor,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        children: [
          _buildProfileHeader(),
          const SizedBox(height: 20),
          _buildSectionTitle("Hesap"),
          _buildTile(icon: Icons.person_outline, title: "Profilim", onTap: () {}),
          _buildTile(icon: Icons.lock_outline, title: "Gizlilik", onTap: () {}),
          _buildTile(icon: Icons.notifications_none, title: "Bildirimler", onTap: () {}),
          const SizedBox(height: 16),
          _buildSectionTitle("Uygulama"),
          _buildTile(
            icon: Icons.brightness_6,
            title: "Tema",
            trailingText: isDark ? "Karanlık" : "Aydınlık",
            onTap: () {},
          ),
          _buildTile(icon: Icons.location_on, title: "Konum Seç", onTap: () {
            controller.navigateWithSlideTransition(context, const PrayerTimesScreen());
          }),

          _buildTile(icon: Icons.info_outline, title: "Hakkımızda", onTap: () {}),
          _buildTile(icon: Icons.star_border, title: "Puanla", onTap: () {}),
          _buildTile(
            icon: Icons.logout,
            title: "Çıkış Yap",
            textColor: Colors.red,
            iconColor: Colors.red,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Row(
      children: [
        const CircleAvatar(
          radius: 30,
          backgroundColor: Color(0xFFE0E0E0),
          child: Icon(Icons.person, size: 30, color: Colors.black),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Ümit Albayrak", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 2),
            Text("umit@mail.com", style: TextStyle(fontSize: 13, color: Colors.grey)),
          ],
        ),
      ],
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
}
