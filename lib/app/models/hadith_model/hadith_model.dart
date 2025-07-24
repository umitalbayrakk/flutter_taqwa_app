class Hadith {
  final String hadisNo;
  final String kaynak;
  final String ravi;
  final String metin;
  final String konu;
  final int hadisSayisi;

  Hadith({
    required this.hadisNo,
    required this.kaynak,
    required this.ravi,
    required this.metin,
    required this.konu,
    required this.hadisSayisi,
  });

  factory Hadith.fromJson(Map<String, dynamic> json) {
    return Hadith(
      hadisNo: json['hadis_no'],
      kaynak: json['kaynak'],
      ravi: json['ravi'],
      metin: json['metin'],
      konu: json['konu'],
      hadisSayisi: json['hadis_sayisi'],
    );
  }
}
