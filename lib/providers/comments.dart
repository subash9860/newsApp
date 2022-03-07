import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/comment.dart';

const String baseUrl = 'https://jsonplaceholder.typicode.com';

class Comments with ChangeNotifier {
  List<Comment> _items = [];
  List<Comment> get items => [..._items];

  // list for share pref
  List<Comment> _itemsOfSharePref = [];
  List<Comment> get itemsOfSharePref => [..._itemsOfSharePref];

  Future<void> fetchComments(int postId) async {

    // fecth comments also form share prefrence
    final prefs = await SharedPreferences.getInstance();
    final extractedComment =
        json.decode(prefs.getString('comments-$postId') ?? '[]');
    final List<Comment> loadedCommentsSharPerf = [];
    extractedComment.forEach((comment) {
      loadedCommentsSharPerf.add(Comment(
        id: comment['id'],
        postId: comment['postId'],
        name: comment['name'],
        email: comment['email'],
        body: comment['body'],
      ));
    });
    _itemsOfSharePref = loadedCommentsSharPerf;
    notifyListeners();

    // fecth comments from api
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
      // Replace the comment list with the new one
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
        'id': Random().nextInt(20),
        'postId': postId,
        'name': "Test",
        'email': "test@mail.com",
        'body': body,
      }),
    );

    // adding comments in share prefrences
    final prefs = await SharedPreferences.getInstance();
    final comments = prefs.getString('comments-$postId') ?? "[]";
    final extractedData = json.decode(comments) as List<dynamic>;
    final newComment = Comment(
      id: Random().nextInt(20),
      postId: postId,
      name: "Test",
      email: "test@mail.com",
      body: body,
    );
    extractedData.add(newComment.toMap());
    final commentsString = json.encode(extractedData);
    prefs.setString('comments-$postId', commentsString);

    // If the server return a 201 CREATED response, parse the JSON.
    if (response.statusCode == 201) {
      final newComment = Comment(
        id: Random().nextInt(20),
        postId: postId,
        name: "Test",
        email: "test@mail.com",
        body: body,
      );
      _items.add(newComment);
      notifyListeners();
    } else {
      throw Exception('Failed to add Comment');
    }
  }
}
