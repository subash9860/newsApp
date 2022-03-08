import 'package:flutter/material.dart';
import '../constants/colors.dart';

Widget topOfpostScreen(Size size) {
  return SizedBox(
    height: size.height * 0.25,
    child: Stack(
      children: [
        Container(
          height: size.height * 0.25 - 50,
          decoration: const BoxDecoration(
            color: kPrimaryDark,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(36),
              bottomRight: Radius.circular(36),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text(
              "Hi, Good morning",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(248, 255, 255, 255),
              ),
            ),
            SizedBox(
              height: size.height * 0.08,
              width: size.width * 0.1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: const CircleAvatar(
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            height: 120,
            width: size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(36),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(0, 10),
                  blurRadius: 25,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(26),
              child: Image.network(
                'https://cdn.dribbble.com/users/63407/screenshots/17574596/media/aa6ed31ff46584de180ed778a02871e4.png?compress=1&resize=1500x900&vertical=top',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
