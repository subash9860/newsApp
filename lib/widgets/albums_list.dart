import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yipl_android_list_me/widgets/photos_list.dart';

import '../widgets/albums_photo.dart';
import '../providers/albums.dart';

class ListofAlbums extends StatelessWidget {
  const ListofAlbums({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Albums>(
      builder: (ctx, users, _) => ListView.separated(
          separatorBuilder: (context, index) =>
              const Divider(color: Colors.black),
          addRepaintBoundaries: true,
          padding: const EdgeInsets.all(10),
          shrinkWrap: true,
          physics: const ScrollPhysics(
              parent: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics())),
          itemCount: users.items.length,
          itemBuilder: (ctx, i) => GestureDetector(
                onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => const ListOfPhotos())),
                child: Stack(
                  children: [
                    SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: AlbumsPhotos(
                          albumID: users.items[i].id,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 60,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.black, Colors.transparent],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            users.items[i].title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
    );
  }
}
