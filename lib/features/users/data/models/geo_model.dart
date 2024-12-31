import '../../domain/entities/geo_entity.dart';

class GeoModel extends GeoEntity{
  GeoModel({
    required super.lat,
    required super.lng,
  });

  factory GeoModel.fromJson(final Map<String, dynamic> json)
  => GeoModel(lat: json["lat"], lng: json["lng"]);

  Map<String, String> toJson()
  => <String, String>{
    "lat": lat,
    "lng": lng
  };
}