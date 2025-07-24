import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter_taqwa_app/app/models/emaul_husna_model/esmaul_husna_model.dart';

class EsmaulHusnaService {
  Future<Resource<EsmaulHusnaDataModel>> randomEsmaulHusnaAndMeaning() async {
    final randomEsmaulHusnaNumber = Random().nextInt(99);
    try {
      final data = await rootBundle.loadString('assets/esmaul_husna.json');
      final jsonResult = jsonDecode(data) as Map<String, dynamic>;
      if (jsonResult['esmaulhusnadata'] == null) {
        return Resource<EsmaulHusnaDataModel>.error(errorType: 'no_data');
      } else {
        final List<EsmaulHusnaDataModel> listOfGodNames = esmaulHusnaDataModelFromJson(
          jsonResult['esmaulhusnadata'] as List<dynamic>,
        );
        return Resource<EsmaulHusnaDataModel>.success(data: listOfGodNames[randomEsmaulHusnaNumber]);
      }
    } catch (e) {
      print("Error occurred: $e");
      return Resource<EsmaulHusnaDataModel>.error(errorType: 'error_occurred');
    }
  }
}

class Resource<T> {
  final T? data;
  final String? errorType;

  const Resource({this.data, this.errorType});

  factory Resource.success({required T data}) => Resource(data: data);
  factory Resource.error({required String errorType}) => Resource(errorType: errorType);
}
