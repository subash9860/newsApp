import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/albums.dart';


class ListofAlbums extends StatelessWidget {
  const ListofAlbums({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Albums>(
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