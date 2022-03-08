import 'package:flutter/material.dart';

import '../widgets/data_on_table.dart';
import '../constants/colors.dart';

Widget topOfUserDetail(BuildContext context, String name,
    String email, String phone, String address, String work) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.278,
    width: MediaQuery.of(context).size.width,
    child: Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          top: 0,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.15,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: kPrimaryDark,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30),
              ),
            ),
          ),
        ),
        Positioned(
          top: 40,
          left: 1,
          child: CircleAvatar(
            radius: MediaQuery.of(context).size.width * 0.15,
            backgroundColor: kPrimary,
            child: Icon(
              Icons.person,
              size: 100,
              color: Colors.grey[200],
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.0955,
          left: MediaQuery.of(context).size.width * 0.3245,
          child: Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // if (backButton)
          Positioned(
            top: 0,
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
          bottom: 0,
          left: MediaQuery.of(context).size.width * 0.24,
          child: DataOnTable(
              name: name,
              email: email,
              phone: phone,
              address: address,
              work: work),
        ),
      ],
    ),
  );
}
