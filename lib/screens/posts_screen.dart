import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yipl_android_list_me/constants/colors.dart';

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
                      children: [
                        TopBarOfPosts(size: size),
                        Expanded(
                          child: Consumer<Posts>(
                            builder: (ctx, posts, _) => ListView.builder(
                              itemCount: posts.items.length,
                              itemBuilder: (ctx, i) => Card(
                                color: Theme.of(context).colorScheme.secondary,
                                child: ListTile(
                                  title: Text(
                                    posts.items[i].title,
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                  contentPadding: const EdgeInsets.all(8),
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, PostDetailsScreen.routeName,
                                        arguments: posts.items[i].id);
                                  },
                                  subtitle: Text(
                                    posts.items[i].body,
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
}
