class ReligiousInfoModel {
  final List<String> islamSartlari;
  final List<String> imanSartlari;

  ReligiousInfoModel({required this.islamSartlari, required this.imanSartlari});

  factory ReligiousInfoModel.fromJson(Map<String, dynamic> json) {
    return ReligiousInfoModel(
      islamSartlari: List<String>.from(json['islam_sartlari']),
      imanSartlari: List<String>.from(json['iman_sartlari']),
    );
  }
}
