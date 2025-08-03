import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_taqwa_app/app/controllers/qazaprayer_calculator_controller.dart';
import 'package:flutter_taqwa_app/app/widgets/app_bar_widgets.dart';
import 'package:flutter_taqwa_app/core/utils/app_colors.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class KazaView extends StatelessWidget {
  final controller = Get.put(KazaController());

  KazaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBarWidgets(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardTheme.color,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        textAlign: TextAlign.start,
                        'Kaza Namazı Takibi',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        textAlign: TextAlign.start,
                        'Dini mükellefiyetlerimiz bülûğ çağından sonra başlamaktadır.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        textAlign: TextAlign.start,
                        '1- Bülûğ çağı kesin olarak bilinmiyorsa\n erkekler yaşlarından 12 seneyi, kadılar ise\n 9 seneyi çıkararak kalan yıllarda namaz kılmayan bütün vakitler hesap...',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Obx(
                () => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardTheme.color,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            'Cinsiyetiniz',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ChoiceChip(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide.none,
                              ),
                              backgroundColor: AppColors.blueColor,
                              selectedColor: AppColors.greenColor,
                              label: Text(
                                'Erkek',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              selected: controller.gender.value == 'Erkek',
                              onSelected: (_) => controller.setGender('Erkek'),
                            ),
                            SizedBox(width: 10),
                            ChoiceChip(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide.none,
                              ),
                              backgroundColor: AppColors.blueColor,
                              selectedColor: AppColors.greenColor,
                              label: Text(
                                'Kadın',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              selected: controller.gender.value == 'Kadın',
                              onSelected: (_) => controller.setGender('Kadın'),
                            ),
                          ],
                        ),
                        Divider(),
                        Text(
                          'Doğum Tarihiniz',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        InkWell(
                          onTap: () async {
                            DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: controller.birthDate.value,
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );
                            if (picked != null) {
                              controller.setBirthDate(picked);
                            }
                          },
                          child: Container(
                            height: 50,
                            width: 200,
                            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                            decoration: BoxDecoration(
                              border: Border.all(color: Theme.of(context).iconTheme.color ?? Colors.black),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              textAlign: TextAlign.center,
                              DateFormat.yMMMMd('tr_TR').format(controller.birthDate.value),
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Divider(),
                        Text(
                          'Buluğ Çağınıza Girdiğiniz Yaş',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          'Alt sınır erkekler için 12 , kadınlar için 9 yaş ',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          width: 70, // genişlik
                          height: 40, // yükseklik
                          child: TextField(
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            onChanged: (value) => controller.setBulughAge(int.tryParse(value) ?? 0),
                            decoration: InputDecoration(
                              hintStyle: Theme.of(context).textTheme.bodyMedium,
                              contentPadding: EdgeInsets.symmetric(horizontal: 8),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                              hintText: '0',
                            ),
                          ),
                        ),
                        Divider(),
                        Center(
                          child: Text(
                            'Kaç Gün Namaz Kıldınız?',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 40,
                              width: 70,
                              child: TextField(
                                textAlign: TextAlign.center,
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                keyboardType: TextInputType.number,
                                onChanged: (value) => controller.setPrayedDays(int.tryParse(value) ?? 0),
                                decoration: InputDecoration(
                                  hintStyle: Theme.of(context).textTheme.bodyMedium,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 8),
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                  hintText: '0',
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.greenColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            shadowColor: AppColors.greenColor.withOpacity(0.3),
                          ),
                          onPressed: () {
                            Get.defaultDialog(
                              title: "Hesaplama Sonucu",
                              content: Text("Toplam kaza namazı gününüz: ${controller.totalQazaDays}"),
                            );
                          },
                          child: Text('Hesapla'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
