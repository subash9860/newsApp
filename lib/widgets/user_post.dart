import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/posts.dart';
import '../widgets/post_card.dart';
import '../screens/post_details_screen.dart';


class UserPost extends StatelessWidget {
  const UserPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Posts>(
      builder: (ctx, posts, _) => ListView.separated(
        separatorBuilder: (context, index) => const Divider(),
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05, vertical: 12),
        physics: const ScrollPhysics(parent: BouncingScrollPhysics()),
        shrinkWrap: true,
        itemCount: posts.itemsOfPostByUser.length,
        itemBuilder: (ctx, i) => GestureDetector(
          child: postCard(
              MediaQuery.of(context).size,
              i,
              context,
              posts.itemsOfPostByUser[i].title.replaceAll("\n", " "),
              posts.itemsOfPostByUser[i].body.replaceAll("\n", " ")),
          onTap: () {
            Navigator.pushNamed(context, PostDetailsScreen.routeName,
                arguments: posts.itemsOfPostByUser[i].id);
          },
        ),
      ),
    );
  }
}