import '../../domain/entities/user_entity.dart';
import 'address_model.dart';
import 'company_model.dart';

class UserModel extends UserEntity{
  UserModel({
    required super.id,
    required super.name,
    required super.username,
    required super.email,
    required super.address,
    required super.phone,
    required super.website,
    required super.company
  });

  factory UserModel.fromJson(final Map<String, dynamic> json)
  => UserModel(
    id: json["id"],
    name: json["name"],
    username: json["username"],
    email: json["email"],
    address: AddressModel.fromJson(json["address"]),
    phone: json["phone"],
    website: json["website"],
    company: CompanyModel.fromJson(json["company"])
  );

  Map<String, dynamic> toJson()
  => <String, dynamic>{
    "id": id,
    "name": name,
    "username": username,
    "email": email,
    "website": website,
    "address": (address as AddressModel).toJson(),
    "phone": phone,
    "company": (company as CompanyModel).toJson()
  };
}

/*
  {
  "id": 1,
  "name": "Leanne Graham",
  "username": "Bret",
  "email": "Sincere@april.biz",
  "address": {
    "street": "Kulas Light",
    "suite": "Apt. 556",
    "city": "Gwenborough",
    "zipcode": "92998-3874",
    "geo": {
      "lat": "-37.3159",
      "lng": "81.1496"
    }
  },
  "phone": "1-770-736-8031 x56442",
  "website": "hildegard.org",
  "company": {
    "name": "Romaguera-Crona",
    "catchPhrase": "Multi-layered client-server neural-net",
    "bs": "harness real-time e-markets"
  }
}
*/