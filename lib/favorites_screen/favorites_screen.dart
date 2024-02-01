import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:visual_magic/main/main_refactor.dart';
import 'package:visual_magic/favorites_screen/refactor.dart';
import 'package:visual_magic/VideoPlayer/video_player.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: MenuDrawer(),
      floatingActionButton: PlayButton(context),
      backgroundColor: const Color(0xff060625),
      appBar: AppBar(
        title: const Text("Favorites"),
        actions: [
          Search(),
        ],
        backgroundColor: const Color(0xff2C2C6D),
      ),
      body: AnimationLimiter(
        child: ListView.builder(
          padding: EdgeInsets.all(w / 30),
          physics:
              const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          itemCount: 20,
          itemBuilder: (BuildContext context, int index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              delay: const Duration(milliseconds: 100),
              child: SlideAnimation(
                duration: const Duration(milliseconds: 2500),
                curve: Curves.fastLinearToSlowEaseIn,
                verticalOffset: -250,
                child: ScaleAnimation(
                  duration: const Duration(milliseconds: 1500),
                  curve: Curves.fastLinearToSlowEaseIn,
                  child: Container(
                    margin: EdgeInsets.only(bottom: w / 20),
                    height: w / 4,
                    decoration: BoxDecoration(
                      color: const Color(0xff1f1f55),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 40,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                    child: Center(
                      child: ListTile(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const VideoPlay()));
                        },
                        leading: Image.asset("assets/images/download.jpeg"),
                        title: const Text(
                          "Camera",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        subtitle: const Text(
                          "10 Videos",
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              showDialog(
                              context: context,
                              builder: (ctx) {
                                return AlertDialog(
                                  backgroundColor: const Color(0xf060625),
                                  content: favouritePopup(),
                                );
                              });
                            },
                            icon: const Icon(
                              Icons.more_vert,
                              color: Colors.white,
                            )),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

