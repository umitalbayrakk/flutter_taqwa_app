import 'package:flutter_taqwa_app/app/models/hadith_model/hadith_model.dart';
import 'package:get/get.dart';
import '../services/hadith_service.dart';

class HadithController extends GetxController {
  final HadithService _hadithService = HadithService();
  var hadith = Rxn<Hadith>();
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchRandomHadith();
  }
  Future<void> fetchRandomHadith() async {
    try {
      isLoading(true);
      final randomHadith = await _hadithService.getRandomHadith();
      hadith.value = randomHadith;
    } catch (e) {
      Get.snackbar('Hata', 'Hadis yüklenirken bir hata oluştu: $e');
    } finally {
      isLoading(false);
    }
  }
}