import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../widgets/albums_list.dart';
import '../widgets/todolist.dart';
import '../widgets/user_post.dart';
import '../providers/todos.dart';
import '../providers/users.dart';
import '../providers/posts.dart';
import '../providers/albums.dart';
import '../constants/colors.dart';
import '../widgets/user_info.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({
    Key? key,
  }) : super(key: key);

  static const routeName = '/users-details';

  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final double coverHeight = 280;
  final double profileHeight = 144;
  @override
  Widget build(BuildContext context) {
    // userID is passed from the user List screen with the UserID as a argument in the route name
    final userID = ModalRoute.of(context)?.settings.arguments as int;

    // every user are filtered by the UserID
    // and findById method is defined in the users.dart file for filtering the user by id
    final user = Provider.of<Users>(context, listen: false).findById(userID);

    // for user's posts
    Provider.of<Posts>(context, listen: false).fetchByUserID(userID);

    // for user's todo list
    Provider.of<Todos>(context, listen: false).fetchAndSetTodos(userID);

    // for user's albums
    Provider.of<Albums>(context, listen: false).fetchAndSetAlbums(userID);

    return UserScreenUi(user: user);
  }
}

class UserScreenUi extends StatelessWidget {
  const UserScreenUi({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 3,
          child: NestedScrollView(
            headerSliverBuilder: (context, _) {
              return [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      UserInfo(
                        name: user.name,
                        email: user.email,
                        phone: user.phone,
                        address: user.address.city,
                        work: user.company.name,
                        // backButton: true,
                      ),
                    ],
                  ),
                ),
              ];
            },
            body: Column(
              children: const [
                TabBar(
                  labelColor: Colors.black,
                  unselectedLabelColor: kPrimary,
                  indicatorWeight: 1,
                  indicatorColor: kPrimaryDark,
                  tabs: [
                    Tab(
                      icon: Icon(
                        Icons.text_snippet_outlined,
                        color: Colors.black,
                      ),
                    ),
                    Tab(
                      icon: Icon(
                        Icons.photo_library_outlined,
                        color: Colors.black,
                      ),
                    ),
                    Tab(
                      icon: Icon(
                        Icons.note_add_rounded,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      UserPost(),
                      ListofAlbums(),
                      Todolist(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
