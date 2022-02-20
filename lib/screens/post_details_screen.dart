import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/comments.dart';
import '../providers/posts.dart';

class PostDetailsScreen extends StatefulWidget {
  const PostDetailsScreen({Key? key}) : super(key: key);

  static const routeName = '/post-details';

  @override
  _PostDetailsScreenState createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    // postID is passed from the Post screen with the postID as a argument in the route name
    final postID = ModalRoute.of(context)?.settings.arguments as int;
    // every post of post are filtered by the postID
    // and findById method is defined in the posts.dart file for filtering the post by id
    final post = Provider.of<Posts>(context, listen: false).findById(postID);

    // Fetching comment by postID from the comments.dart file
    Provider.of<Comments>(context, listen: false).fetchComments(postID);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Post Details"),
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 10),
          Text("Post Title: ${post.title}",
              style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 10),
          Text("Post Body: ${post.body}", style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 30),
          const Text('Comments', style: TextStyle(fontSize: 20)),
          const SizedBox(height: 10),
          Expanded(
            child: Consumer<Comments>(
              builder: (ctx, comments, _) => ListView.builder(
                itemCount: comments.items.length,
                itemBuilder: (ctx, i) => ListTile(
                  title: Card(
                      margin: const EdgeInsets.all(10),
                      child: Text(comments.items[i].body,
                          style: const TextStyle(fontSize: 18))),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
