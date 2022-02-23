import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';
import '../screens/post_details_screen.dart';
import '../providers/posts.dart';
import '../widgets/top_bar_of_posts.dart';

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
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 7,
      ),
      body: SafeArea(
        child: Container(
          child: _isloading
              ? const CircularProgressIndicator()
              : justTry
                  ? const Center(child: Text('Something went wrong'))
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TopBarOfPosts(size: size),
                        SizedBox(
                          height: size.height * 0.015,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: size.width * 0.05,
                              vertical: size.height * 0.01),
                          child: const Text(
                            "Lists of posts",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(137, 2, 1, 1),
                            ),
                          ),
                        ),
                        ListOfPosts(size: size),
                      ],
                    ),
        ),
      ),
    );
  }
}

class ListOfPosts extends StatelessWidget {
  const ListOfPosts({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<Posts>(
        builder: (ctx, posts, _) => ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          physics: const ScrollPhysics(parent: BouncingScrollPhysics()),
          // itemExtent: 20.0 * size.height / 100,
          shrinkWrap: true,
          itemCount: posts.items.length,
          itemBuilder: (ctx, i) => Container(
            margin: EdgeInsets.only(bottom: size.height * 0.02),
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color.fromARGB(234, 253, 251, 251),
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 10),
                  blurRadius: 10,
                ),
              ],
            ),
            child: ListTile(
              visualDensity: VisualDensity.standard,
              isThreeLine: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
              leading: FittedBox(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: const Image(
                        image: NetworkImage(
                            'https://cdn.dribbble.com/users/642793/screenshots/6577615/attachments/1405726/issue_9_inside_1.jpg?compress=1&resize=900x800&vertical=top'))),
              ),
              title: Text(posts.items[i].title.toUpperCase(),
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.lato(
                    color: const Color.fromARGB(207, 0, 0, 0),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    wordSpacing: 3,
                  )),
              subtitle: Text(posts.items[i].body,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.lato(
                    color: const Color.fromARGB(164, 0, 0, 0),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    wordSpacing: 3,
                  )),
              trailing: const Icon(Icons.arrow_forward, color: kPrimary),
              selectedColor: kPrimary,
              selected: true,
              onTap: () {
                Navigator.pushNamed(context, PostDetailsScreen.routeName,
                    arguments: posts.items[i].id);
              },
            ),
          ),
        ),
      ),
    );
  }
}
