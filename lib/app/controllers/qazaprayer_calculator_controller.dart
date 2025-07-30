import 'package:get/get.dart';

class KazaController extends GetxController {
  var gender = ''.obs;
  var birthDate = DateTime.now().obs;
  var bulughAge = 0.obs;
  var prayedDays = 0.obs;

  void setGender(String selectedGender) {
    gender.value = selectedGender;
  }

  void setBirthDate(DateTime date) {
    birthDate.value = date;
  }

  void setBulughAge(int age) {
    bulughAge.value = age;
  }

  void setPrayedDays(int days) {
    prayedDays.value = days;
  }

  int get totalQazaDays {
    final bulughDate = DateTime(
      birthDate.value.year + bulughAge.value,
      birthDate.value.month,
      birthDate.value.day,
    );
    final now = DateTime.now();
    final totalDays = now.difference(bulughDate).inDays;
    return totalDays - prayedDays.value;
  }
}
