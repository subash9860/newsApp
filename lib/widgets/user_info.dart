import 'package:flutter/material.dart';

import '../widgets/top_of_user_detail.dart';

class UserInfo extends StatelessWidget {
  const UserInfo(
      {Key? key,
      required this.name,
      required this.email,
      required this.phone,
      required this.address,
      required this.work})
      : super(key: key);

  final String name;
  final String email;
  final String phone;
  final String work;
  final String address;

  @override
  Widget build(BuildContext context) {
    return topOfUserDetail(context, name, email, phone, address, work);
  }
}
