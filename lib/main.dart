import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './constants/colors.dart';
import './screens/home_screen.dart';
import './providers/photos.dart';
import './providers/albums.dart';
import './providers/todos.dart';
import './screens/user_detail.dart';
// import './screens/user_list.dart';
import '../providers/users.dart';
import './providers/comments.dart';
import './providers/posts.dart';
// import '../screens/posts_screen.dart';
import '../screens/post_details_screen.dart';
import '../screens/user_detail.dart';

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
        ChangeNotifierProvider(create: (_) => Comments()),
        ChangeNotifierProvider(create: (_) => Users()),
        ChangeNotifierProvider(create: (_) => Todos()),
        ChangeNotifierProvider(create: (_) => Albums()),
        ChangeNotifierProvider(create: (_) => Photos())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'List-Me',
        theme: ThemeData(
          primaryColor: kPrimary,
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blueGrey)
              .copyWith(secondary: const Color.fromARGB(255, 145, 193, 233)),
          textTheme: Theme.of(context).textTheme.apply(
                fontSizeFactor: 1.14,
                bodyColor: const Color.fromARGB(255, 0, 0, 0),
                displayColor: const Color.fromARGB(255, 0, 0, 0),
              ),
          appBarTheme:const AppBarTheme(
            color:kPrimaryDark,
          )
        ),
        home: const HomeScreen(),
        // const UserList(),
        //  const PostsScreen(),
        routes: {
          PostDetailsScreen.routeName: (ctx) => const PostDetailsScreen(),
          // UserList.routeName: (ctx) => const UserList(),
          UserDetailsScreen.routeName: (ctx) => const UserDetailsScreen(),
        },
      ),
    );
  }
}
