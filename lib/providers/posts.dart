import 'package:flutter/foundation.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/post.dart';


const String baseUrl = 'https://jsonplaceholder.typicode.com';

class Posts with ChangeNotifier {
  List<Post> _items = [];

  List<Post> get items => [..._items];

  Future<void> fetchAndSetPosts() async {
    final response = await http.get(Uri.parse('$baseUrl/posts'));

    // If the server return a 200 OK response, parse the JSON.
    if (response.statusCode == 200) {
      final extractedData = json.decode(response.body);
      final List<Post> loadedPosts = [];

      // Parse the JSON to a dart list of Post objects
      extractedData.forEach((post) {
        loadedPosts.add(Post(
          userId: post['userId'],
          id: post['id'],
          title: post['title'],
          body: post['body'],
        ));
      });
      // Replace the posts list with the new one
      _items = loadedPosts;
      notifyListeners();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Posts');
    }
  }

  Post findById(int id) {
    return _items.firstWhere((element) => element.id == id);
    // _items.firstWhereOrNull((index, element) => e)((prod) => prod.id == id);
  }
}
