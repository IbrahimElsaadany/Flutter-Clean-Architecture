import '../../domain/entities/address_entity.dart';
import 'geo_model.dart';

class AddressModel extends AddressEntity{
  AddressModel({
    required super.city,
    required super.geo,
    required super.street,
    required super.suite,
    required super.zipcode
  });

  factory AddressModel.fromJson(final Map<String, dynamic> json)
  => AddressModel(
    city: json["city"],
    geo: GeoModel.fromJson(json["geo"]),
    street: json["street"],
    suite: json["suite"],
    zipcode: json["zipcode"]
  );

  Map<String, dynamic> toJson()
  => <String, dynamic>{
    "city": city,
    "geo": (geo as GeoModel).toJson()
  };
}