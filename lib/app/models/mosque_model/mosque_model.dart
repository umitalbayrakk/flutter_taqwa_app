import 'package:latlong2/latlong.dart';

class Mosque {
  final String? name;
  final LatLng location;

  Mosque({this.name, required this.location});

  factory Mosque.fromJson(Map<String, dynamic> json) {
    return Mosque(
      name: json['tags']['name'],
      location: LatLng(json['lat'], json['lon']),
    );
  }
}