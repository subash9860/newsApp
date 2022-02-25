import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/photos.dart';
import '../providers/todos.dart';
import '../providers/users.dart';
import '../providers/posts.dart';
import '../providers/albums.dart';
import '../constants/colors.dart';
import '../widgets/user_info.dart';
import '../widgets/post_card.dart';
import '../screens/post_details_screen.dart';

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

    // for user's photos
    Provider.of<Photos>(context, listen: false).fetchAndSetPhotos(userID);

    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 4,
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
                          work: user.company.name),
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
                        Icons.photo_album_outlined,
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
                      ListOfpost(),
                      ListofAlbums(),
                      ListOfPhotos(),
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

class ListofAlbums extends StatelessWidget {
  const ListofAlbums({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Todos>(
      builder: (ctx, users, _) => ListView.builder(
        itemCount: users.items.length,
        itemBuilder: (ctx, i) => ListTile(
          title: Text(
            users.items[i].title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class ListOfpost extends StatelessWidget {
  const ListOfpost({Key? key}) : super(key: key);

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

class ListOfPhotos extends StatelessWidget {
  const ListOfPhotos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Photos>(
        builder: (ctx, photos, _) => ListView.builder(
            itemCount: photos.items.length,
            itemBuilder: (ctx, i) => Stack(
                  children: [
                    SizedBox(
                      height: 180,
                      width: 180,
                      child: Image.network(
                        photos.items[i].thumbnailUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: SizedBox(
                            height: 180,
                            width: 180,
                            child: Image.network(
                              photos.items[i].url,
                              fit: BoxFit.cover,
                            ))),
                  ],
                )));
  }
}

class Todolist extends StatelessWidget {
  const Todolist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Todos>(
      builder: (ctx, users, _) => ListView.builder(
        itemCount: users.items.length,
        itemBuilder: (ctx, i) => ListTile(
          title: Text(
            users.items[i].title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
//  // User's Todo List
// Consumer<Todos>(
//             builder: (ctx, users, _) => ListView.builder(
//                   itemCount: users.items.length,
//                   itemBuilder: (ctx, i) => ListTile(
//                     title: Text(
//                       users.items[i].title,
//                       style: const TextStyle(
//                           fontSize: 22, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),
//            ),
//  ),