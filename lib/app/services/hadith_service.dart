import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter_taqwa_app/app/models/hadith_model/hadith_model.dart';

class HadithService {
  Future<List<Hadith>> loadHadiths() async {
    final String response = await rootBundle.loadString('assets/hadith.json');
    final data = json.decode(response);
    return (data['hadisler'] as List).map((json) => Hadith.fromJson(json)).toList();
  }

  Future<Hadith> getRandomHadith() async {
    final hadiths = await loadHadiths();
    return hadiths[Random().nextInt(hadiths.length)];
  }
}
