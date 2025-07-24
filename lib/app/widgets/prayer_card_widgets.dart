import 'package:flutter/material.dart';
import 'package:flutter_taqwa_app/core/utils/app_colors.dart';

class PrayerCardWidgets extends StatelessWidget {
  const PrayerCardWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 300,
        decoration: BoxDecoration(color: AppColors.greenColor, borderRadius: BorderRadius.circular(20.0)),
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('6 Ramazan 1442', style: TextStyle(color: Colors.white, fontSize: 18)),
            Column(
              children: [
                Text(
                  'İkindiye Kalan',
                  style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text('01:20:22', style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_on, color: Colors.white),
                SizedBox(width: 8),
                Text('Beşiktaş / İstanbul', style: TextStyle(color: Colors.white, fontSize: 18)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Güneş: 05:57', style: TextStyle(color: Colors.white)),
                Text('İmsak: 05:57', style: TextStyle(color: Colors.white)),
                Text('Öğlen: 05:57', style: TextStyle(color: Colors.white)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('İkindi: 05:57', style: TextStyle(color: Colors.white)),
                Text('Akşam: 05:57', style: TextStyle(color: Colors.white)),
                Text('Yatsı: 05:57', style: TextStyle(color: Colors.white)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
