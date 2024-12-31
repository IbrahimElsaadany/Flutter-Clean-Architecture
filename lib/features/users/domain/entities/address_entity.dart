import 'geo_entity.dart';

class AddressEntity{
  final String street, suite, city, zipcode;
  final GeoEntity geo;

  AddressEntity({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    required this.geo,
  });
}