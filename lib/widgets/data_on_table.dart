import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DataOnTable extends StatelessWidget {
  final String name;
  final String email;
  final String phone;
  final String address;
  final String work;
  const DataOnTable(
      {Key? key,
      required this.name,
      required this.email,
      required this.phone,
      required this.address,
      required this.work})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(0.3),
          1: FlexColumnWidth(1),
        },
        children: [
          TableRow(children: [
            Icon(Icons.email, color: Colors.grey[600]),
            Text(email,
                style:
                    GoogleFonts.roboto(fontSize: 18, color: Colors.grey[600])),
          ]),
          TableRow(children: [
            Icon(Icons.phone, color: Colors.grey[600]),
            Text(phone,
                style:
                    GoogleFonts.roboto(fontSize: 18, color: Colors.grey[600])),
          ]),
          TableRow(children: [
            Icon(Icons.work, color: Colors.grey[600]),
            Text(work,
                style:
                    GoogleFonts.roboto(fontSize: 18, color: Colors.grey[600])),
          ]),
          TableRow(children: [
            Icon(Icons.place, color: Colors.grey[600]),
            Text(address,
                style:
                    GoogleFonts.roboto(fontSize: 18, color: Colors.grey[600])),
          ]),
        ],
      ),
    );
  }
}
