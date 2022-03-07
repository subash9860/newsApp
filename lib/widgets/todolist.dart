import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/todos.dart';

class Todolist extends StatelessWidget {
  const Todolist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Todos>(
      builder: (ctx, users, _) => ListView.builder(
        itemCount: users.items.length,
        itemBuilder: (ctx, i) => ListTile(
          title: Text(
            users.items[i].title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}