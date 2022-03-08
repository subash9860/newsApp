import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Column(
          children: const [
            ListTile(
              leading: CircleAvatar(
                  radius: 30,
                  child: Icon(
                    Icons.person,
                    size: 30,
                  )),
              title: Text(
                'Rame jshoseph',
                style: TextStyle(fontSize: 20),
              ),
              subtitle: Text('ramesh.345@cma.com'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.person_sharp),
              title: Text('prosonal info'),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('settings'),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('logout'),
            ),
          ],
        ),
      ),
    );
  }
}
