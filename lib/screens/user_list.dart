import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../providers/users.dart';
import '../screens/user_detail.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  static const routeName = '/user-list';

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
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
        Provider.of<Users>(context).fetchAndSetUsers().then((value) => (_) {
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
    return Scaffold(
      appBar: AppBar(
      elevation: 5,
        centerTitle: true,
        title: const Text('List of Users'),
      ),
      body: Center(
        child: _isloading
            ? const CircularProgressIndicator()
            : justTry
                ? const Text('Something went wrong')
                : Consumer<Users>(
                    builder: (context, users, child) => ListView.separated(
                      separatorBuilder: (_, index) => const SizedBox(),
                      addRepaintBoundaries: true,
                      addAutomaticKeepAlives: true,
                      addSemanticIndexes: true,
                      padding: const EdgeInsets.all(10),
                      physics: const ScrollPhysics(
                        parent: BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics(),
                        ),
                      ),
                      itemCount: users.items.length,
                      itemBuilder: (context, index) => ListTile(
                        visualDensity: VisualDensity.comfortable,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        leading: const CircleAvatar(child: Icon(Icons.person)),
                        title: Text(
                          users.items[index].name,
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          users.items[index].username,
                          style: GoogleFonts.roboto(
                            color: Colors.grey[600],
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios_outlined),
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            UserDetailsScreen.routeName,
                            arguments: users.items[index].id,
                          );
                        },
                      ),
                    ),
                  ),
      ),
    );
  }
}
