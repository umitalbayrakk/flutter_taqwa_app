import 'package:get/get.dart';

class DhikrController extends GetxController {
  // Reaktif sayaç
  var counter = 0.obs;

  void increment() {
    counter++;
  }

  void reset() {
    counter.value = 0;
  }
}
