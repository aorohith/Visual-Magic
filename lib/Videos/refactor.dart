import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:visual_magic/main/main_refactor.dart';
import 'package:visual_magic/main/showcase_inherited.dart';
import 'package:visual_magic/VideoPlayer/video_player.dart';
import 'package:visual_magic/db/functions.dart';

//List tile for video list view builder

Widget getListView(
    {required index, required context, required videosWithIndex}) {
  return ListTile(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VideoPlay(
            videoLink: videosWithIndex[index].path,
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
      videosWithIndex[index].title,
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
    subtitle: const Text(
      "10 Videos",
      style: TextStyle(color: Colors.white),
    ),
    trailing: index == 0
        ? Showcase(
            targetShapeBorder: const CircleBorder(),
            tooltipBackgroundColor: Colors.indigo,
            descTextStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 16,
            ),
            key: KeysToBeInherited.of(context).key4,
            description: "Add to Favorites Here",
            child: Favorites(),
          )
        : Favorites(),
  );
}

//List tile ends here

class SortDropdown extends StatefulWidget {
  const SortDropdown({Key? key}) : super(key: key);

  @override
  State<SortDropdown> createState() => _SortDropdownState();
}

class _SortDropdownState extends State<SortDropdown> {
  String dropdownValue = 'A to Z';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      borderRadius: BorderRadius.circular(10),
      dropdownColor: Colors.black,
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down),
      elevation: 16,
      style: const TextStyle(color: Colors.white),
      underline: Container(
        height: 2,
        color: Colors.black,
      ),
      onChanged: (String? newValue) {
        switch (newValue) {
          case "A to Z":
            sortAlphabetical();
            break;
          case "Duration":
            sortByDuration();
            break;
          case "Date":
            sortBySize();
            break;
          case "FileSize":
          // sortByDate();
        }
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>['A to Z', 'Duration', 'Date', 'FileSize']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
