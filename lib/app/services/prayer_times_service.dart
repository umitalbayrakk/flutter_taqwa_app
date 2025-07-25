import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class PrayerTimesService {
  Future<List<dynamic>> searchLocations(String query) async {
    if (query.length < 3) return [];
    try {
      final response = await http.get(Uri.parse('https://vakit.vercel.app/api/searchPlaces?q=$query&lang=tr'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data is List ? data : [];
      } else {
        throw Exception('Hata: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Bağlantı hatası: $e');
    }
  }

  Future<Map<String, dynamic>> fetchPrayerTimes(String locationId) async {
    try {
      final now = DateTime.now();
      final formattedDate = DateFormat('yyyy-MM-dd').format(now);
      final response = await http.get(
        Uri.parse(
          'https://vakit.vercel.app/api/timesForPlace?id=$locationId&date=$formattedDate&days=1&timezoneOffset=180&calculationMethod=Turkey',
        ),
      );
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        if (decodedData is Map && decodedData.containsKey('times')) {
          return decodedData.cast<String, dynamic>();
        } else {
          throw Exception('Geçersiz veri formatı');
        }
      } else {
        throw Exception('Sunucu hatası: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('İşlem hatası: $e');
    }
  }
}