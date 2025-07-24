import 'package:flutter/material.dart';
import 'package:flutter_taqwa_app/core/utils/app_colors.dart';

class PrayertoreminderCardWidget extends StatefulWidget {
  const PrayertoreminderCardWidget({super.key});

  @override
  State<PrayertoreminderCardWidget> createState() => _PrayertoreminderCardWidgetState();
}

class _PrayertoreminderCardWidgetState extends State<PrayertoreminderCardWidget> {
  String? cevap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: BorderRadius.circular(16.0)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Text(
                cevap ?? "Namazını kıldın mı?",
                style: TextStyle(
                  fontSize: cevap == null ? 16 : 14,
                  fontWeight: cevap == null ? FontWeight.w600 : FontWeight.w400,
                  fontStyle: cevap != null ? FontStyle.italic : FontStyle.normal,
                  color: AppColors.blackColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _buildButton(
                    text: "Evet",
                    color: Colors.green[700]!,
                    onPressed: () {
                      setState(() {
                        cevap = "Tebrikler, Allah kabul etsin!";
                      });
                    },
                  ),
                  const SizedBox(width: 8),
                  _buildButton(
                    text: "Hayır",
                    color: Colors.red[700]!,
                    onPressed: () {
                      setState(() {
                        cevap = "Vakit geçmeden kılabilirsin.";
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton({required String text, required Color color, required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        shadowColor: color.withOpacity(0.3),
      ),
      child: Text(text, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
    );
  }
}
