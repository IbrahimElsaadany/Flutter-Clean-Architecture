import '../../domain/entities/company_entity.dart';

class CompanyModel extends CompanyEntity{
  CompanyModel({
    required super.name,
    required super.catchPhrase,
    required super.bs
  });

  factory CompanyModel.fromJson(final Map<String, dynamic> json)
  => CompanyModel(
    name: json["name"],
    catchPhrase: json["catchPhrase"],
    bs: json["bs"]
  );

  Map<String, String> toJson()
  => <String, String>{
    "name": name,
    "catchPrase": catchPhrase,
    "bs": bs
  };
}