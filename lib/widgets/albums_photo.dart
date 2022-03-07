import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/photos.dart';

class AlbumsPhotos extends StatelessWidget {
  final int albumID;
  const AlbumsPhotos({Key? key, required this.albumID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // // for user's photos
    Provider.of<Photos>(context, listen: false).fetchAndSetPhotos(albumID);

    return Consumer<Photos>(
      builder: (context, photos, child) => ListView.builder(
        itemCount: photos.items.length,
        itemBuilder: (context, index) =>
            Image.network(photos.items[Random().nextInt(49)].thumbnailUrl, fit: BoxFit.cover),
      ),
    );
  }
}
