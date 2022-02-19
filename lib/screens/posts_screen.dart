import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/posts.dart';

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
        print(error);
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: Center(
        child: _isloading
            ? const CircularProgressIndicator()
            : justTry
                ? const Text('Something went wrong')
                : Consumer<Posts>(
                    builder: (ctx, posts, _) => ListView.builder(
                      itemCount: posts.items.length,
                      itemBuilder: (ctx, i) => Card(
                        color: Theme.of(context).colorScheme.secondary,
                        child: ListTile(
                          title: Text(
                            posts.items[i].title,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          contentPadding: const EdgeInsets.all(8),
                          onTap: (){
                            // TODO: Navigate to post Details
                          },
                          subtitle: Text(
                            posts.items[i].body,
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
