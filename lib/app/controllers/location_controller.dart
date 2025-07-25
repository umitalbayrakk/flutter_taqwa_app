import 'package:flutter_taqwa_app/app/services/location_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  Rx<Position?> currentPosition = Rx<Position?>(null);
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCurrentLocation();
  }

  Future<void> fetchCurrentLocation() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      Position? position = await LocationService.getCurrentLocation();

      if (position != null) {
        currentPosition.value = position;
      } else {
        errorMessage.value = "Konum alınamadı. Lütfen izinleri kontrol edin.";
      }
    } catch (e) {
      errorMessage.value = "Hata oluştu: $e";
    } finally {
      isLoading.value = false;
    }
  }
}
