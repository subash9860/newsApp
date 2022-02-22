import 'package:flutter/foundation.dart';

class User with ChangeNotifier {
  int id;
  String name;
  String username;
  String email;
  Address address;
  String phone;
  String website;
  Company company;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
    required this.company,
  });
}

class Address with ChangeNotifier {
  String street;
  String suite;
  String city;
  String zipcode;
  Geo geo;

  Address({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    required this.geo,
  });
}

class Geo with ChangeNotifier {
  String lat;
  String lng;

  Geo({
    required this.lat,
    required this.lng,
  });
}

class Company with ChangeNotifier {
  String name;
  String catchPhrase;
  String bs;

  Company({
    required this.name,
    required this.catchPhrase,
    required this.bs,
  });
}
