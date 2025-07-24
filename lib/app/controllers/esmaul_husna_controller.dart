import 'package:flutter_taqwa_app/app/models/emaul_husna_model/esmaul_husna_model.dart';
import 'package:flutter_taqwa_app/app/services/esmaul_husna_service.dart';
import 'package:get/get.dart';


class EsmaulHusnaController extends GetxController {
  final EsmaulHusnaService _esmaulHusnaService = EsmaulHusnaService();
  final Rx<EsmaulHusnaDataModel?> esmaulHusna = Rx<EsmaulHusnaDataModel?>(null);
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchRandomEsmaulHusna();
  }

  Future<void> fetchRandomEsmaulHusna() async {
    isLoading.value = true;
    final result = await _esmaulHusnaService.randomEsmaulHusnaAndMeaning();
    esmaulHusna.value = result.data;
    isLoading.value = false;
  }
}