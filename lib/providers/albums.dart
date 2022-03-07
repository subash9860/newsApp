import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/album.dart';

class Albums with ChangeNotifier {
  List<Album> _items = [];
  List<Album> get items => [..._items];

  Future<void> fetchAndSetAlbums(int userID) async {
    final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/users/$userID/albums'));

    // if the server returns with a 200 OK response, parse the JSON
    if (response.statusCode == 200) {
      final extractedData = json.decode(response.body);
      final List<Album> loadedAlbum = [];
      // iterate through the extracted data and create a albums object for each one
      extractedData.forEach((albumData) {
        loadedAlbum.add(Album(
          id: albumData['id'],
          title: albumData['title'],
          userId: albumData['userId'],
        ));
      });
      _items = loadedAlbum;
      notifyListeners();
    } else {
      throw Exception('Failed to load albums');
    }
  }
}
