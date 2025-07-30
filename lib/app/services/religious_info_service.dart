import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_taqwa_app/app/models/religious_information_model/religious_information.dart';

class ReligiousInfoService {
  Future<ReligiousInfoModel> fetchReligiousInfo() async {
    final String response = await rootBundle.loadString('assets/religious_information.json');
    final data = await json.decode(response);
    return ReligiousInfoModel.fromJson(data);
  }
}
