import 'package:flutter/material.dart';

import '../../domain/entities/user_entity.dart';
import '../widgets/info_item.dart';

class UserPage extends StatelessWidget{
  final UserEntity user;

  const UserPage(this.user, {super.key});

  @override
  Scaffold build(final BuildContext context)
  => Scaffold(
    appBar: AppBar(
      title: Text("User Info"),
    ),
    body: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10.0),
          CircleAvatar(
            radius: 50.0,
            child: Icon(
              Icons.person_4_rounded,
              size: 90.0,
            ),
          ),
          SizedBox(height: 10.0),
          infoItem(
            context: context,
            label: "Personal Info",
            data: {
              "Name": user.name,
              "Phone": user.phone,
              "Email": user.email,
              "Website": user.website,
            }
          ),
          SizedBox(height: 20.0),
          infoItem(
            context: context,
            label: "Address Info",
            data: {
              "City": user.address.city,
              "Street": user.address.street,
              "Suite": user.address.suite,
              "Zipcode": user.address.suite,
              "Geo": "(${user.address.geo.lat}, ${user.address.geo.lng})"
            }
          ),
          SizedBox(height: 20.0),
          infoItem(
            context: context,
            label: "Company Info",
            data: {
              "Name": user.company.name,
              "BS": user.company.bs,
              "Catch Phrase": user.company.catchPhrase,
            }
          ),
          
        ],
      ),
    ),
  );
}