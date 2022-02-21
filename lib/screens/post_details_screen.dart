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
  final _commentController = TextEditingController();
  final _scrollController = ScrollController();

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
                controller: _scrollController,
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
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 50,
                width: 300,
                margin: const EdgeInsets.only(bottom: 20),
                child: Stack(children: [
                  TextField(
                    controller: _commentController,
                    onTap: (() {
                      _scrollController.animateTo(
                          _scrollController.position.maxScrollExtent,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease);
                    }),
                    decoration: InputDecoration(
                        fillColor: Colors.grey[150],
                        filled: true,
                        contentPadding: const EdgeInsets.all(18),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none),
                        hintText: "Add a comment",
                        hintStyle: const TextStyle(
                          color: Colors.black54,
                        )),
                  ),
                  Positioned(
                      right: 8,
                      bottom: 8,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.blue[600],
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () {
                            if (_commentController.text.isNotEmpty) {
                              // print(_commentController.text);
                              Provider.of<Comments>(context, listen: false)
                              .addComment(postID, _commentController.text);
                              _commentController.clear();
                            }
                          },
                        ),
                      ))
                ]),
              )),
        ],
      ),
    );
  }
}
