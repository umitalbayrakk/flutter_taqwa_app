class EsmaulHusnaDataModel {
  final String id;
  final String okunusu;
  final String anlami;
  final String arapca;
  final String? resim;

  EsmaulHusnaDataModel({
    required this.id,
    required this.okunusu,
    required this.anlami,
    required this.arapca,
    this.resim,
  });

  factory EsmaulHusnaDataModel.fromJson(Map<String, dynamic> json) {
    return EsmaulHusnaDataModel(
      id: json['ID'] ?? '',
      okunusu: json['OKUNUSU'] ?? '',
      anlami: json['ANLAMI'] ?? '',
      arapca: json['ARAPCA'] ?? '',
      resim: json['RESIM'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'OKUNUSU': okunusu,
      'ANLAMI': anlami,
      'ARAPCA': arapca,
      'RESIM': resim,
    };
  }
}

List<EsmaulHusnaDataModel> esmaulHusnaDataModelFromJson(List<dynamic> jsonList) {
  return List<EsmaulHusnaDataModel>.from(
    jsonList.map((json) => EsmaulHusnaDataModel.fromJson(json as Map<String, dynamic>)),
  );
}