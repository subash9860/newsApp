import 'package:flutter/foundation.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/post.dart';

const String baseUrl = 'https://jsonplaceholder.typicode.com';

class Posts with ChangeNotifier {
  List<Post> _items = [];

  List<Post> get items => [..._items];

  Future<void> fetchAndSetPosts() async {
    final responseForAllPost = await http.get(Uri.parse('$baseUrl/posts'));

    // If the server return a 200 OK response, parse the JSON.
    if (responseForAllPost.statusCode == 200) {
      final extractedData = json.decode(responseForAllPost.body);
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
  }


// fetching posts by user id

  List<Post> _itemsOfPostByUser = [];
  List<Post> get itemsOfPostByUser => [..._itemsOfPostByUser];

  Future<void> fetchByUserID(int userID) async {
    final responseByUserID = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/users/$userID/posts'));

    // If the server return a 200 OK response, parse the JSON.
    if (responseByUserID.statusCode == 200) {
      final extractedData1 = json.decode(responseByUserID.body);
      final List<Post> loadedPosts1 = [];

      // Parse the JSON to a dart list of Post objects
      extractedData1.forEach((post) {
        loadedPosts1.add(Post(
          userId: post['userId'],
          id: post['id'],
          title: post['title'],
          body: post['body'],
        ));
      });
      // Replace the posts list with the new one
      _itemsOfPostByUser = loadedPosts1;
      notifyListeners();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Posts by user id');
    }
  }
}
