import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/todos.dart';
import '../providers/users.dart';
// import '../providers/comments.dart';
import '../providers/posts.dart';
import '../providers/albums.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({Key? key}) : super(key: key);

  static const routeName = '/users-details';

  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    // userID is passed from the user List screen with the UserID as a argument in the route name
    final userID = ModalRoute.of(context)?.settings.arguments as int;

    // every user are filtered by the UserID
    // and findById method is defined in the users.dart file for filtering the user by id
    final user = Provider.of<Users>(context, listen: false).findById(userID);

    // for user's posts
    Provider.of<Posts>(context, listen: false).fetchByUserID(userID);

    // for user's todo list
    Provider.of<Todos>(context, listen: false).fetchAndSetTodos(userID);

    // for user's albums
    Provider.of<Albums>(context, listen: false).fetchAndSetAlbums(userID);

    return Scaffold(
      appBar: AppBar(
        title: const Text("User Details"),
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 10),
          Text(
            user.name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text("User Posts"),

          // for user's posts
          Expanded(
            child: Consumer<Posts>(
              builder: (ctx, posts, _) => ListView.builder(
                itemCount: posts.itemsOfPostByUser.length,
                itemBuilder: (ctx, i) => ListTile(
                  // contentPadding: const EdgeInsets.all(10),
                  title: Text(
                    posts.itemsOfPostByUser[i].title,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(posts.itemsOfPostByUser[i].body),
                ),
              ),
            ),
          ),
          // User's Todo List
          const Text("User's Todo List"),
          Expanded(
            child: Consumer<Todos>(
              builder: (ctx, users, _) => ListView.builder(
                itemCount: users.items.length,
                itemBuilder: (ctx, i) => ListTile(
                  // contentPadding: const EdgeInsets.all(10),
                  title: Text(
                    users.items[i].title,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(users.items[i].completed.toString()),
                ),
              ),
            ),
          ),

          // User's Albums
          const Text("User's Albums"),
          Expanded(
            child: Consumer<Albums>(
              builder: (ctx, albums, _) => ListView.builder(
                itemCount: albums.items.length,
                itemBuilder: (ctx, i) => ListTile(
                  // contentPadding: const EdgeInsets.all(10),
                  title: Text(
                    albums.items[i].title,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(albums.items[i].userId.toString()),
                ),
              ),
            ),
          ),
          // User's Photos
        ],
      ),
    );
  }
}
