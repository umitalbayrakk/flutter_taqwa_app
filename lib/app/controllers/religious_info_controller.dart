import 'package:flutter_taqwa_app/app/models/religious_information_model/religious_information.dart';
import 'package:get/get.dart';
import '../services/religious_info_service.dart';

class ReligiousInfoController extends GetxController {
  final ReligiousInfoService _service = ReligiousInfoService();

  var isLoading = true.obs;
  var religiousInfo = Rxn<ReligiousInfoModel>();

  @override
  void onInit() {
    super.onInit();
    loadReligiousInfo();
  }

  void loadReligiousInfo() async {
    try {
      isLoading(true);
      final data = await _service.fetchReligiousInfo();
      religiousInfo.value = data;
    } finally {
      isLoading(false);
    }
  }
}
