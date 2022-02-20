import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/posts.dart';
import '../screens/posts_screen.dart';
import '../screens/post_details_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Posts(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'List-Me',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blueGrey)
              .copyWith(secondary: const Color.fromARGB(255, 145, 193, 233)),
          textTheme: Theme.of(context).textTheme.apply(
                fontSizeFactor: 1.14,
                bodyColor: const Color.fromARGB(255, 0, 0, 0),
                displayColor: const Color.fromARGB(255, 0, 0, 0),
              ),
        ),
        home: const PostsScreen(),
        routes: {
          PostDetailsScreen.routeName: (ctx) => const PostDetailsScreen(),
        },
      ),
    );
  }
}
