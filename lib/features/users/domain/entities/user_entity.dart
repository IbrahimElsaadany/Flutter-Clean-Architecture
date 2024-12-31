import 'address_entity.dart';
import 'company_entity.dart';

class UserEntity{
  final int id;
  final String name, username, email, phone, website;
  final AddressEntity address;
  final CompanyEntity company;

  UserEntity({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.website,
    required this.address,
    required this.company
  });
}