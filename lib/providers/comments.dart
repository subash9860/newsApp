import 'package:flutter/foundation.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/comment.dart';

const String baseUrl = 'https://jsonplaceholder.typicode.com';

class Comments with ChangeNotifier {
  List<Comment> _items = [];

  List<Comment> get items => [..._items];
  int i = 6;

  Future<void> fetchComments(int postId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/posts/$postId/comments'));

    // If the server return a 200 OK response, parse the JSON.
    if (response.statusCode == 200) {
      final extractedData = json.decode(response.body);

      final List<Comment> loadedComments = [];

      // Parse the JSON to a dart list of Comment objects

      extractedData.forEach((comment) {
        loadedComments.add(Comment(
          id: comment['id'],
          postId: comment['postId'],
          name: comment['name'],
          email: comment['email'],
          body: comment['body'],
        ));
      });

      // Replace the posts list with the new one
      _items = loadedComments;
      notifyListeners();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Comments');
    }
  }

// Adding new comment by post method but jsonPlacehplder but doest not store the comment in the database

  Future<void> addComment(int postId, String body) async {
    final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/posts/$postId/comments'),
      body: json.encode({
        'id': i++,
        'postId': postId,
        'name': "Test",
        'email': "test@mail.com",
        'body': body,
      }),
    );

    if (response.statusCode == 201) {
      final newComment = Comment(
        id: i++,
        postId: postId,
        name: "Test",
        email: "test@mail.com",
        body: body,
      );
      _items.add(newComment);
      notifyListeners();
    } else {
      // print(response.statusCode);
      throw Exception('Failed to add Comment');
    }
  }
}
