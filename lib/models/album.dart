import 'package:flutter/foundation.dart';

class Album with ChangeNotifier {
  int userId;
  int id;
  String title;
  Album({
    required this.userId,
    required this.id,
    required this.title,
  });
}
