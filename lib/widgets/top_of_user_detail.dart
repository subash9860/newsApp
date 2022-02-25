import 'package:flutter/material.dart';

Widget topOfUserDetail(BuildContext context) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.309,
    width: MediaQuery.of(context).size.width,
    child: Stack(
      alignment: Alignment.center,
      children: [
        Positioned(top: 0, child: buildCoverImage(context)),
        Positioned(top: 100, child: buildProfileImage()),
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
      ],
    ),
  );
}

Widget buildCoverImage(context) => Container(
      width: MediaQuery.of(context).size.width,
      height: 164,
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(
              'https://images.pexels.com/photos/1535907/pexels-photo-1535907.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'),
        ),
      ),
    );

Widget buildProfileImage() => CircleAvatar(
      radius: 65,
      backgroundColor: Colors.grey.shade800,
      backgroundImage: const NetworkImage(
          "https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&h=600&w=600"),
    );
