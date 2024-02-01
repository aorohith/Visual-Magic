import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:visual_magic/main/main_refactor.dart';
import 'package:visual_magic/main/showcase_inherited.dart';
import 'package:visual_magic/videos/refactor.dart';
import 'package:visual_magic/db/functions.dart';

class VideosScreen extends StatefulWidget {
  const VideosScreen({Key? key}) : super(key: key);
  @override
  State<VideosScreen> createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    // bool isPressed = true;
    // bool isPressed2 = true;
    // bool isHighlighted = true;
    return Scaffold(
      drawer: const MenuDrawer(),
      floatingActionButton: playButton(context),
      backgroundColor: const Color(0xff060625),
      appBar: AppBar(
        title: const Text("All Videos"),
        actions: [
          const Search(),
          Showcase(
            tooltipBackgroundColor: Colors.indigo,
            descTextStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 16,
            ),
            key: KeysToBeInherited.of(context).key2,
            description: "Sort your videos here",
            child: const SortDropdown(),
          ),
          IconButton(
            onPressed: () {
              ShowCaseWidget.of(context).startShowCase([
                KeysToBeInherited.of(context).key1,
                KeysToBeInherited.of(context).key2,
                KeysToBeInherited.of(context).key3,
                KeysToBeInherited.of(context).key4,
              ]);
            },
            icon: const Icon(Icons.help_outline_outlined),
          ),
        ],
        backgroundColor: const Color(0xff2C2C6D),
      ),
      body: AnimationLimiter(
        child: ValueListenableBuilder(
            valueListenable: fetchedVideosWithInfo,
            builder: (BuildContext ctx, List<dynamic> videosWithIndex,
                Widget? child) {
              log(videosWithIndex.length.toString());
              return ListView.builder(
                padding: EdgeInsets.all(w / 30),
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemCount: videosWithIndex.length,
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
                            child: index == 0
                                ? Showcase(
                                    targetShapeBorder: const CircleBorder(),
                                    tooltipBackgroundColor: Colors.indigo,
                                    descTextStyle: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                    key: KeysToBeInherited.of(context).key3,
                                    description:
                                        "Long Press to view the more info",
                                    child: getListView(
                                      index: index,
                                      context: context,
                                      videosWithIndex: videosWithIndex,
                                    ))
                                : getListView(
                                    index: index,
                                    context: context,
                                    videosWithIndex: videosWithIndex,
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
