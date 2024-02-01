import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:visual_magic/main/main_refactor.dart';
import 'package:visual_magic/VideoPlayer/video_player.dart';
import 'package:visual_magic/db/functions.dart';

List<String>? fetchedVideos;

class FolderVideos extends StatefulWidget {
  final String path;
  const FolderVideos({Key? key, required this.path}) : super(key: key);

  @override
  State<FolderVideos> createState() => _FolderVideosState();
}

class _FolderVideosState extends State<FolderVideos> {
  @override
  void initState() {
    getFolderVideos(widget.path);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    // bool isPressed = true;
    // bool isPressed2 = true;
    // bool isHighlighted = true;
    return Scaffold(
      drawer: const MenuDrawer(),
      floatingActionButton:  playButton(context),
      backgroundColor: const Color(0xff060625),
      appBar: AppBar(
        title: const Text("Camera"),
        backgroundColor: const Color(0xff2C2C6D),
      ),
      body: AnimationLimiter(
        child: ValueListenableBuilder(
          valueListenable: filteredFolderVideos,
          builder: (BuildContext ctx, List<dynamic> folderVideosList,
              Widget? child) {
            return ListView.builder(
              padding: EdgeInsets.all(w / 30),
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              itemCount: folderVideosList.length,
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
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VideoPlay(
                                    videoLink: folderVideosList[index],
                                  ),
                                ),
                              );
                            },
                            onLongPress: () {
                              showDialog(
                                  context: context,
                                  builder: (ctx) {
                                    return AlertDialog(
                                      backgroundColor: const Color(0xff060625),
                                      content: optionPopup(),
                                    );
                                  });
                            },
                            leading: Image.asset("assets/images/download.jpeg"),
                            title: Text(
                              folderVideosList[index].split('/').last,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: const Text(
                              "10 Videos",
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: Favorites(),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
