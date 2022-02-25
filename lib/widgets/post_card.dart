import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';

String toCapilized(String input) {
  final List<String> splitStr = input.split(' ');
  for (int i = 0; i < splitStr.length; i++) {
    splitStr[i] = '${splitStr[i][0].toUpperCase()}${splitStr[i].substring(1)}';
  }
  final output = splitStr.join(' ');
  return output;
}

String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

Widget postCard(
        Size size, int i, BuildContext context, String title, String body) =>
    Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(234, 253, 251, 251),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(26),
          topRight: Radius.circular(26),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 10),
            blurRadius: 10,
          ),
        ],
      ),
      child: Stack(
        children: [
          SizedBox(
            height: size.height * 0.14,
            child: const ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(26),
                // bottomLeft: Radius.circular(2),
              ),
              child: Image(
                image: NetworkImage(
                    'https://cdn.dribbble.com/users/642793/screenshots/6577615/attachments/1405726/issue_9_inside_1.jpg?compress=1&resize=400x400&vertical=middle'),
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: size.width * 0.30,
            child: SizedBox(
              width: size.width * 0.64,
              child: Text(
                toCapilized(title),
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.lato(
                  color: const Color.fromARGB(207, 0, 0, 0),
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  wordSpacing: 3,
                ),
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: size.width * 0.30,
            child: SizedBox(
              width: size.width * 0.60,
              height: size.height * 0.05,
              child: Text(
                capitalize(body),
                softWrap: true,
                style: GoogleFonts.lato(
                  color: const Color.fromARGB(164, 0, 0, 0),
                  fontWeight: FontWeight.bold,
                  wordSpacing: 3,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: size.width * 0.30,
            child: Row(
              children: const [
                Text(
                  "see more...  ",
                  style: TextStyle(color: kPrimary),
                ),
                Icon(
                  Icons.arrow_forward,
                  color: kPrimary,
                )
              ],
            ),
          )
        ],
      ),
    );
