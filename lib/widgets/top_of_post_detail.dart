import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';

Widget topOfPostDetail(BuildContext context, Size size, String title) {
  return Container(
    color: kPrimaryDark,
    child: SizedBox(
      height: size.height * 0.31,
      child: Stack(
        children: [
          Positioned(
            top: 25,
            left: 10,
            child: CircleAvatar(
              backgroundColor: const Color.fromARGB(132, 223, 219, 219),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 60,
            left: 50,
            child: SizedBox(
              height: size.height * 0.25,
              width: size.width * 0.89,
              child: Text(title.replaceAll("\n", " "),
                  style: GoogleFonts.roboto(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ),
          Positioned(
              top: 145,
              left: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Chip(
                      backgroundColor: kPrimary,
                      label: Text(
                        "tag1",
                        style: TextStyle(color: Colors.white),
                      )),
                  SizedBox(width: 30),
                  Chip(
                      backgroundColor: kPrimary,
                      label: Text(
                        "tag2",
                        style: TextStyle(color: Colors.white),
                      )),
                ],
              )),
          Positioned(
            top: size.height * 0.25,
            child: Container(
              height: size.height * 0.2,
              width: size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(46),
                  topRight: Radius.circular(46),
                ),
              ),
              child: const SizedBox(),
            ),
          ),
          Positioned(
            top: size.height * 0.25,
            left: 40,
            child: Chip(
              label: Text("Description:",
                  style: GoogleFonts.roboto(
                      fontSize: 21,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold)),
            ),
          )
        ],
      ),
    ),
  );
}
