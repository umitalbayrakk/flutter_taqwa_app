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
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBarWidgets(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                height: 186,
                child: Card(
                  color: AppColors.whiteColor,
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          textAlign: TextAlign.start,
                          'Kaza Namazı Takibi',
                          style: Theme.of(
                            context,
                          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: AppColors.blackColor),
                        ),
                        Text(
                          textAlign: TextAlign.start,
                          'Dini mükellefiyetlerimiz bülûğ çağından sonra başlamaktadır.',
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: AppColors.blackColor),
                        ),
                        Text(
                          textAlign: TextAlign.start,
                          '1- Bülûğ çağı kesin olarak bilinmiyorsa\n erkekler yaşlarından 12 seneyi, kadılar ise\n 9 seneyi çıkararak kalan yıllarda namaz kılmayan bütün vakitler hesap...',
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: AppColors.blackColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Obx(
                () => SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: Card(
                    color: AppColors.whiteColor,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      tileColor: AppColors.whiteColor,
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              'Cinsiyetiniz',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.blackColor,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ChoiceChip(
                                backgroundColor: AppColors.darkThemeColor,
                                selectedColor: AppColors.greenColor,
                                label: Text(
                                  'Erkek',
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                                selected: controller.gender.value == 'Erkek',
                                onSelected: (_) => controller.setGender('Erkek'),
                              ),
                              SizedBox(width: 10),
                              ChoiceChip(
                                backgroundColor: AppColors.darkThemeColor,
                                selectedColor: AppColors.greenColor,
                                label: Text(
                                  'Kadın',
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                                selected: controller.gender.value == 'Kadın',
                                onSelected: (_) => controller.setGender('Kadın'),
                              ),
                            ],
                          ),
                          Divider(),
                          Text(
                            'Doğum Tarihiniz',
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: AppColors.blackColor),
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
                              decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(8)),
                              child: Text(DateFormat.yMMMMd('tr_TR').format(controller.birthDate.value)),
                            ),
                          ),
                          Divider(),
                          Text(
                            'Buluğ Çağınıza Girdiğiniz Yaş',
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: AppColors.blackColor),
                          ),
                          Text(
                            textAlign: TextAlign.center,
                            'Alt sınır erkekler için 12 , kadınlar için 9 yaş ',
                            style: Theme.of(
                              context,
                            ).textTheme.bodySmall?.copyWith(color: AppColors.blackColor.withOpacity(0.8)),
                          ),
                          SizedBox(height: 10),
                          SizedBox(
                            width: 70, // genişlik
                            height: 40, // yükseklik
                            child: TextField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              onChanged: (value) => controller.setBulughAge(int.tryParse(value) ?? 0),
                              decoration: InputDecoration(
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
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.blackColor,
                              ),
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
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) => controller.setPrayedDays(int.tryParse(value) ?? 0),
                                  decoration: InputDecoration(
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
            ),
          ],
        ),
      ),
    );
  }
}
