import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/posts.dart';
import '../screens/posts_screen.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Posts(),
        ),
      ],
      child: MaterialApp(
        title: 'List-Me',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blueGrey)
                  .copyWith(secondary: const Color.fromARGB(255, 4, 56, 99)),
                  textTheme: Theme.of(context).textTheme.apply(
                    fontSizeFactor: 1.14,
                    bodyColor: const Color.fromARGB(255, 241, 243, 245),
                    displayColor: const Color.fromARGB(255, 196, 199, 202),
                  ),
        ),
        home: const PostsScreen()
      ),
    );
  }
}