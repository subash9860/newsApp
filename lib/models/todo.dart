import 'package:flutter/foundation.dart';

class Todo with ChangeNotifier {
  int userId;
  int id;
  String title;
  bool completed;
  Todo({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });
}
