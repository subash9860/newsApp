import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yipl_android_list_me/providers/users.dart';

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
        title: const Text('List of Users'),
      ),
      body: Center(
        child: _isloading
            ? const CircularProgressIndicator()
            : justTry
                ? const Text('Something went wrong')
                : Consumer<Users>(
                    builder: (context, users, child) => ListView.builder(
                      itemCount: users.items.length,
                      itemBuilder: (context, index) => ListTile(
                        title: Text(users.items[index].name),
                      ),
                    ),
                  ),
      ),
    );
  }
}
