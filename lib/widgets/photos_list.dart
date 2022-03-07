import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/photos.dart';


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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
