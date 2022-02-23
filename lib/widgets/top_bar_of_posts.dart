import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/users.dart';
import '../providers/photos.dart';
import '../constants/colors.dart';

class TopBarOfPosts extends StatefulWidget {
  const TopBarOfPosts({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  State<TopBarOfPosts> createState() => _TopBarOfPostsState();
}

class _TopBarOfPostsState extends State<TopBarOfPosts>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );

  final _isiniti = true;

  var _isloading = false;
  var _isloading1 = false;

  var justTry = false;

  @override
  void didChangeDependencies() {
    if (_isiniti) {
      setState(() {
        _isloading = true;
      });
      try {
        Provider.of<Photos>(context).fetchAndSetPhotos(1).then((value) => (_) {
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
      try {
        Provider.of<Users>(context, listen: false)
            .fetchAndSetUsers()
            .then((value) => (_) {
                  setState(() {
                    _isloading1 = false;
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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.size.height * 0.25,
      child: _isloading && _isloading1
          ? const CircularProgressIndicator()
          : justTry
              ? const Center(child: Text('Something went wrong'))
              : Stack(
                  children: [
                    Container(
                      height: widget.size.height * 0.25 - 50,
                      decoration: const BoxDecoration(
                        color: kPrimaryDark,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(36),
                          bottomRight: Radius.circular(36),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Consumer<Users>(
                          builder: (context, user, _) => Text(
                            "Hi, ${user.findById(1).name} !",
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(248, 255, 255, 255),
                            ),
                          ),
                        ),
                        ClipOval(
                          child: Consumer<Photos>(
                              builder: (context, photos, _) => SizedBox(
                                    height: 60,
                                    width: 60,
                                    child: FadeTransition(
                                      opacity: _animation,
                                      alwaysIncludeSemantics: true,
                                      child: ClipOval(
                                        child:
                                            Image.network(photos.items[3].url),
                                      ),
                                    ),
                                  )),
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        height: 120,
                        width: widget.size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(36),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black,
                              offset: Offset(0, 10),
                              blurRadius: 25,
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(26),
                          child: Image.network(
                            'https://cdn.dribbble.com/users/63407/screenshots/17574596/media/aa6ed31ff46584de180ed778a02871e4.png?compress=1&resize=1500x900&vertical=top',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }
}
