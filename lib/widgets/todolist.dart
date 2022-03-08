import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../providers/todos.dart';

class Todolist extends StatefulWidget {
  const Todolist({Key? key}) : super(key: key);

  @override
  State<Todolist> createState() => _TodolistState();
}

class _TodolistState extends State<Todolist> {
  bool addcomment = false;
  final _addtodoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CircleAvatar(
        radius: 32,
        child: IconButton(
            color: kPrimary,
            onPressed: () {
              setState(() {
                addcomment = !addcomment;
              });
            },
            icon: const Icon(
              Icons.add,
              color: Colors.black,
              size: 32,
            )),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      body: Consumer<Todos>(
        builder: (ctx, todo, _) => Stack(
          children: [
            ListView.builder(
              itemCount: todo.items.length,
              padding: const EdgeInsets.all(8),
              physics: const ScrollPhysics(
                  parent: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics())),
              itemBuilder: (ctx, i) => ListTile(
                leading: Checkbox(
                    activeColor: kPrimary,
                    value: todo.items[i].completed,
                    onChanged: (_) {
                      todo.items[i].completed = !todo.items[i].completed;
                      todo.updateTodo(todo.items[i]);
                    }),
                title: (todo.items[i].completed)
                    ? Text(todo.items[i].title,
                        style: GoogleFonts.roboto(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey))
                    : Text(todo.items[i].title,
                        style: GoogleFonts.roboto(
                            fontSize: 20, fontWeight: FontWeight.w600)),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    todo.deleteTodo(todo.items[i].id);
                  },
                ),
              ),
            ),
            // ),
            if (addcomment)
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  height: 50,
                  width: 300,
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Stack(
                    children: [
                      TextField(
                        controller: _addtodoController,
                        decoration: InputDecoration(
                          fillColor: Colors.grey[300],
                          filled: true,
                          contentPadding: const EdgeInsets.all(18),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none),
                          hintText: "Add a new todo",
                          hintStyle: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: IconButton(
                          icon: const Icon(Icons.send, color: Colors.black),
                          onPressed: () {
                            if (_addtodoController.text.isNotEmpty) {
                              todo.addTodo(_addtodoController.text, false, 1);
                              _addtodoController.clear();
                              setState(() {
                                addcomment = false;
                              });
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
