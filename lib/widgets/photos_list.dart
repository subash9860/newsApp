import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/photos.dart';

class ListOfPhotos extends StatelessWidget {
  const ListOfPhotos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of photos'),
      ),
      body: Consumer<Photos>(
        builder: (ctx, photos, _) => ListView.builder(
          itemCount: photos.items.length,
          itemBuilder: (ctx, i) => 
          Card(
            child: Image.network(photos.items[i].url)
          ),
        ),
      ),
    );
  }
}
