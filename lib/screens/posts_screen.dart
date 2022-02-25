import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/list_of_post.dart';
// import '../screens/post_details_screen.dart';
import '../constants/colors.dart';
import '../providers/posts.dart';
// import '../widgets/post_card.dart';
import '../widgets/top_of_post_screen.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  _PostsScreenState createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  final _isiniti = true;
  var _isloading = false;
  var justTry = false;

  @override
  void didChangeDependencies() {
    if (_isiniti) {
      setState(() {
        _isloading = true;
      });
      try {
        Provider.of<Posts>(context).fetchAndSetPosts().then((value) => (_) {
              setState(() {
                _isloading = false;
              });
            });
      } catch (error) {
        // print(error);
        setState(() {
          justTry = true;
        });
      }
    }
    _isloading = false;
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kGrey,
      body: SafeArea(
        child: Container(
          child: _isloading
              ? const CircularProgressIndicator()
              : justTry
                  ? const Center(child: Text('Something went wrong'))
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        topOfpostScreen(size),
                        SizedBox(
                          height: size.height * 0.015,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: size.width * 0.05,
                              vertical: size.height * 0.01),
                          child: const Text(
                            "Recent News",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(137, 2, 1, 1),
                            ),
                          ),
                        ),

                        const ListOfPost(),
                        // Expanded(
                        //   child: Consumer<Posts>(
                        //     builder: (ctx, posts, _) => ListView.separated(
                        //       separatorBuilder: (context, index) =>
                        //           const Divider(),
                        //       padding: EdgeInsets.symmetric(
                        //           horizontal: size.width * 0.05),
                        //       physics: const ScrollPhysics(
                        //           parent: BouncingScrollPhysics()),
                        //       shrinkWrap: true,
                        //       itemCount: posts.items.length,
                        //       itemBuilder: (ctx, i) => GestureDetector(
                        //         child: postCard(
                        //             size,
                        //             i,
                        //             context,
                        //             posts.items[i].title.replaceAll("\n", " "),
                        //             capitalize(posts.items[i].body)
                        //                 .replaceAll("\n", " ")),
                        //         onTap: () {
                        //           Navigator.pushNamed(
                        //               context, PostDetailsScreen.routeName,
                        //               arguments: posts.items[i].id);
                        //         },
                        //       ),
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
        ),
      ),
    );
  }
}
