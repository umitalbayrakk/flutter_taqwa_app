import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DhikrController extends GetxController {
  var counter = 0.obs;
  var selectedDhikr = "".obs;
  var dhikrList = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadDhikrList();

    // dhikrList değiştikçe otomatik kaydet
    ever(dhikrList, (_) => saveDhikrList());
  }

  void increment() {
    if (selectedDhikr.isNotEmpty) {
      counter++;
    }
  }

  void resetCounter() {
    counter.value = 0;
  }

  void selectDhikr(String dhikr) {
    if (selectedDhikr.value == dhikr) {
      selectedDhikr.value = "";
    } else {
      selectedDhikr.value = dhikr;
      resetCounter();
    }
  }

  Future<void> addDhikr(String dhikr) async {
    if (!dhikrList.contains(dhikr)) {
      dhikrList.add(dhikr);
      // saveDhikrList() otomatik kaydediliyor ever() ile
    }
  }

  Future<void> removeDhikr(String dhikr) async {
    dhikrList.remove(dhikr);
    if (selectedDhikr.value == dhikr) {
      selectedDhikr.value = "";
      resetCounter();
    }
    // saveDhikrList() otomatik kaydediliyor ever() ile
  }

  Future<void> saveDhikrList() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('dhikr_list', dhikrList.toList());
  }

  Future<void> loadDhikrList() async {
    final prefs = await SharedPreferences.getInstance();
    final savedList = prefs.getStringList('dhikr_list') ?? [];
    dhikrList.assignAll(savedList);
  }
}
