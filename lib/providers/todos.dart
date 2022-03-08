import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/todo.dart';

class Todos with ChangeNotifier {
  List<Todo> _items = [];
  List<Todo> get items => [..._items];

  Future<void> fetchAndSetTodos(int userID) async {
    final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/users/$userID/todos'));

    // if the server returns with a 200 OK response, parse the JSON
    if (response.statusCode == 200) {
      final extractedData = json.decode(response.body);
      final List<Todo> loadedTodos = [];
      // iterate through the extracted data and create a Todo object for each one
      extractedData.forEach((todoData) {
        loadedTodos.add(Todo(
          userId: todoData['userId'],
          id: todoData['id'],
          title: todoData['title'],
          completed: todoData['completed'],
        ));
      });
      _items = loadedTodos;
      notifyListeners();
    } else {
      throw Exception('Failed to load todos');
    }
  }

  updateTodo(Todo todo) {
    final index = _items.indexWhere((todoItem) => todoItem.id == todo.id);
    if (index >= 0) {
      _items[index] = todo;
      notifyListeners();
    }
  }

  addTodo(String title, bool completed, int userId) {
    _items.add(Todo(
      id: _items.length + 1,
      title: title,
      completed: completed,
      userId: userId,
    ));
    notifyListeners();
  }

  deleteTodo(int id) {
    _items.removeWhere((todo) => todo.id == id);
    notifyListeners();
  }
}
