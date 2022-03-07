import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/post_details_screen.dart';
import '../providers/posts.dart';
import '../widgets/post_card.dart';

class AllPost extends StatelessWidget {
  const AllPost({Key? key}) : super(key: key);

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<Posts>(
        builder: (ctx, posts, _) => ListView.separated(
          separatorBuilder: (context, index) => const Divider(),
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05),
          physics: const ScrollPhysics(parent: BouncingScrollPhysics()),
          shrinkWrap: true,
          itemCount: posts.items.length,
          itemBuilder: (ctx, i) => GestureDetector(
            child: postCard(
                MediaQuery.of(context).size,
                i,
                context,
                posts.items[i].title.replaceAll("\n", " "),
                posts.items[i].body.replaceAll("\n", " ")),
            onTap: () {
              Navigator.pushNamed(context, PostDetailsScreen.routeName,
                  arguments: posts.items[i].id);
            },
          ),
        ),
      ),
    );
  }
}
