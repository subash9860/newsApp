import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post Details"),
      ),
      body: SingleChildScrollView(
        child: Card(
          child: Column(
            children: <Widget>[
              Text(
                post.title,
                style: const TextStyle(fontSize: 20),
              ),
              const Divider(
                  thickness: 2, color: Colors.black, indent: 10, endIndent: 30),
              Text(
                post.body,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
