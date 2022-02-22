import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/user.dart';

class Users with ChangeNotifier {
  List<User> _items = [];
  List<User> get items => [..._items];

  Future<void> fetchAndSetUsers() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    // if the server responds with a 200 OK response, parse the JSON
    if (response.statusCode == 200) {
      final extractedData = json.decode(response.body);

      final List<User> loadedUsers = [];

      // iterate through the extracted data and create a new User object

      extractedData.forEach((userData) {
        loadedUsers.add(
          User(
            id: userData['id'],
            name: userData['name'],
            username: userData['username'],
            email: userData['email'],

            // Address object assigned to the user
            address: Address(
              street: userData['address']['street'],
              suite: userData['address']['suite'],
              city: userData['address']['city'],
              zipcode: userData['address']['zipcode'],
              
              // Geometry object assigned to the GeoLocation
              geo: Geo(
                lat: userData['address']['geo']['lat'],
                lng: userData['address']['geo']['lng'],
              ),
            ),
            phone: userData['phone'],
            website: userData['website'],

            // Company object assigned to the user
            company: Company(
              name: userData['company']['name'],
              catchPhrase: userData['company']['catchPhrase'],
              bs: userData['company']['bs'],
            ),
          ),
        );
      });
      _items = loadedUsers;
      notifyListeners();
    } else {
      throw Exception('Failed to load users');
    }
    notifyListeners();
  }
  // filter users by id
  User findById(int id) {
    return _items.firstWhere((element) => element.id == id);
  }
}
