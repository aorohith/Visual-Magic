import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:visual_magic/home_screen/folder_videos.dart';
import 'package:visual_magic/main/main_refactor.dart';
import 'package:visual_magic/main/showcase_inherited.dart';
import 'package:visual_magic/db/functions.dart';

// List<String>? _fetchedFolders;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // _fetchedFolders = getFolderList();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: MenuDrawer(),
      floatingActionButton: PlayButton(context),
      backgroundColor: const Color(0xff060625),
      appBar: AppBar(
        title: const Text("Folders"),
        actions: [
          ElevatedButton(
            onPressed: () async {
              print("Button Clicked");
              print(filteredFolderVideos.value.length);
              // final videoDB = await Hive.openBox<VideoModel>('video_db');
              // print(videoDB.values.length);
            },
            child: const Text("Hai"),
          ),
          Search(), //Search Refactor
          IconButton(
            onPressed: () {
              ShowCaseWidget.of(context).startShowCase([
                KeysToBeInherited.of(context).key1,
                KeysToBeInherited.of(context).key2,
                KeysToBeInherited.of(context).key3,
              ]);
            },
            icon: const Icon(Icons.help_outline_outlined),
          ),
        ],
        backgroundColor: const Color(0xff1f1f55),
      ),
      body: AnimationLimiter(
        child: ValueListenableBuilder(
            valueListenable: fetchedFolders,
            builder:
                (BuildContext ctx, List<String> updatedFolders, Widget? child) {
              return ListView.builder(
                padding: EdgeInsets.all(_w / 30),
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemCount: updatedFolders.length,
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
                          margin: EdgeInsets.only(bottom: _w / 20),
                          height: _w / 4,
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
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (ctx) =>
                                      FolderVideos(path: updatedFolders[index]),
                                ),
                              ),
                              leading: const Icon(
                                Icons.folder_outlined,
                                size: 60,
                                color: Colors.white,
                              ),

                              title: index ==
                                      0 //turnery operator for showcase to select first element of folder
                                  ? Showcase(
                                      targetShapeBorder: const CircleBorder(),
                                      tooltipBackgroundColor: Colors.indigo,
                                      descTextStyle: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                      key: KeysToBeInherited.of(context).key2,
                                      description: "Folder name is here",
                                      child: Text(
                                        updatedFolders[index].split('/').last,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ))
                                  : Text(
                                      updatedFolders[index].split('/').last,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ), //Turnery end here

                              subtitle: const Text(
                                "10 Videos",
                                style: TextStyle(color: Colors.white),
                              ),

                              //Turnery operator
                              trailing: index == 0
                                  ? Showcase(
                                      targetShapeBorder: const CircleBorder(),
                                      tooltipBackgroundColor: Colors.indigo,
                                      descTextStyle: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                      key: KeysToBeInherited.of(context).key3,
                                      description: "More info ",
                                      child: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.more_vert,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  : IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.more_vert,
                                        color: Colors.white,
                                      ),
                                    ),

                              //Turnery operator ends here
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
      ),
    );
  }
}
