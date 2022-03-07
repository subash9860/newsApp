import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/photo.dart';

class Photos with ChangeNotifier {
  List<Photo> _items = [];
  List<Photo> get items => [..._items];

  Future<void> fetchAndSetPhotos(int albumID) async {
    final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/albums/$albumID/photos'));

    // if the server returns with a 200 OK response, parse the JSON
    if (response.statusCode == 200) {
      final extractedData = json.decode(response.body);
      final List<Photo> loadedPhoto = [];
      // iterate through the extracted data and create a photos object for each one
      extractedData.forEach((photosData) {
        loadedPhoto.add(Photo(
          albumId: photosData['albumId'],
          id: photosData['id'],
          title: photosData['title'],
          url: photosData['url'],
          thumbnailUrl: photosData['thumbnailUrl'],
        ));
      });
      _items = loadedPhoto;
      notifyListeners();
    } else {
      throw Exception('Failed to load photos');
    }
  }
}
