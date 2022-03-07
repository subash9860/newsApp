import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../providers/comments.dart';
import '../providers/posts.dart';
import '../widgets/top_of_post_detail.dart';

class PostDetailsScreen extends StatefulWidget {
  const PostDetailsScreen({Key? key}) : super(key: key);

  static const routeName = '/post-details';

  @override
  _PostDetailsScreenState createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
  final _commentController = TextEditingController();
  final _scrollController = ScrollController();

  String toCapilized(String input) {
    final List<String> splitStr = input.split(' ');
    for (int i = 0; i < splitStr.length; i++) {
      splitStr[i] =
          '${splitStr[i][0].toUpperCase()}${splitStr[i].substring(1)}';
    }
    final output = splitStr.join(' ');
    return output;
  }

  String firstLettercapitalize(String s) => s[0].toUpperCase() + s.substring(1);

  @override
  Widget build(BuildContext context) {
    // postID is passed from the Post screen with the postID as a argument in the route name
    final postID = ModalRoute.of(context)?.settings.arguments as int;
    // every post of post are filtered by the postID
    // and findById method is defined in the posts.dart file for filtering the post by id
    final post = Provider.of<Posts>(context, listen: false).findById(postID);

    // Fetching comment by postID from the comments.dart file
    Provider.of<Comments>(context, listen: false).fetchComments(postID);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          topOfPostDetail(context, size, toCapilized(post.title)),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
            width: size.width * 0.86,
            child: Text(firstLettercapitalize(post.body).replaceAll("\n", " "),
                style: GoogleFonts.roboto(
                    fontSize: 19,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500)),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 40),
            child: Chip(
                label: Text("Comments",
                    style: GoogleFonts.roboto(
                        fontSize: 22,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold))),
          ),
          Expanded(
            child: Consumer<Comments>(
              builder: (ctx, comments, _) => ListView.builder(
                controller: _scrollController,
                itemCount:
                    comments.items.length + comments.itemsOfSharePref.length,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                physics: const ScrollPhysics(
                  parent: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                ),
                itemBuilder: (ctx, i) => Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  color: Colors.grey[200],
                  margin: const EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: (i < comments.items.length
                        ? Text(
                            comments.items[i].body.replaceAll("\n", " "),
                            style: GoogleFonts.roboto(
                                fontSize: 18,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500),
                          )
                        : Text(
                            comments.itemsOfSharePref[i - comments.items.length]
                                .body,
                            style: GoogleFonts.roboto(
                                fontSize: 18,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500),
                          )),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 50,
              width: 300,
              margin: const EdgeInsets.only(bottom: 10),
              child: Stack(
                children: [
                  TextField(
                    controller: _commentController,
                    onTap: (() {
                      _scrollController.animateTo(
                          _scrollController.position.maxScrollExtent,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease);
                    }),
                    decoration: InputDecoration(
                      fillColor: Colors.grey[300],
                      filled: true,
                      contentPadding: const EdgeInsets.all(18),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none),
                      hintText: "Add a comment",
                      hintStyle: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 2,
                    child: IconButton(
                      icon: const Icon(
                        Icons.send,
                        color: Color.fromARGB(221, 45, 170, 187),
                        size: 30,
                      ),
                      onPressed: () {
                        if (_commentController.text.isNotEmpty) {
                          Provider.of<Comments>(context, listen: false)
                              .addComment(postID, _commentController.text);
                          _commentController.clear();
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
