import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        topOfUserDetail(context),
        Text(
          name,
          style: GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.w500),
        ),
        const Divider(),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(1.5),
              1: FlexColumnWidth(2),
            },
            children: [
              TableRow(children: [
                Text('Email',
                    style: GoogleFonts.roboto(
                        fontSize: 18, color: Colors.grey[600])),
                Text(email,
                    style: GoogleFonts.roboto(
                        fontSize: 18, color: Colors.grey[600])),
              ]),
              TableRow(children: [
                Text('Phone',
                    style: GoogleFonts.roboto(
                        fontSize: 18, color: Colors.grey[600])),
                Text(phone,
                    style: GoogleFonts.roboto(
                        fontSize: 18, color: Colors.grey[600])),
              ]),
              TableRow(children: [
                Text('Work',
                    style: GoogleFonts.roboto(
                        fontSize: 18, color: Colors.grey[600])),
                Text(work,
                    style: GoogleFonts.roboto(
                        fontSize: 18, color: Colors.grey[600])),
              ]),
              TableRow(children: [
                Text('Address',
                    style: GoogleFonts.roboto(
                        fontSize: 18, color: Colors.grey[600])),
                Text(address,
                    style: GoogleFonts.roboto(
                        fontSize: 18, color: Colors.grey[600])),
              ]),
            ],
          ),
        ),
      ],
    );
  }
}
