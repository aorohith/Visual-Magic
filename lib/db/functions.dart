import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_video_info/flutter_video_info.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:visual_magic/fetch_files/search_files.dart';
import 'package:visual_magic/db/Models/video_model.dart';

final videoInfo = FlutterVideoInfo(); //creating object of info class
List<String> fetchedVideosPath = []; //all videos path loaded first time
ValueNotifier<List<String>> fetchedFolders = ValueNotifier([]); //folder list
List<String> temp = []; //temp directory for folder function
ValueNotifier<List> fetchedVideosWithInfo =
    ValueNotifier([]); //videos with info
ValueNotifier<List> filteredFolderVideos =
    ValueNotifier([]); //folder click videos

onSuccess(List<String> data) {
  fetchedVideosPath = data;
  for (int i = 0; i < fetchedVideosPath.length; i++) {
    if (fetchedVideosPath[i].startsWith('/storage/emulated/0/Android/data')) {
      fetchedVideosPath.remove(fetchedVideosPath[i]);
      i--;
    }
  }
  loadFolderList();
  getVideoWithInfo();
}

//first called from splash screen
Future<void> splashFetch() async {
  // if (await _requestPermission(Permission.storage)) {
  //   // final videoDB = await Hive.openBox<VideoModel>('video_db');
  //   SearchFilesInStorage.searchInStorage([
  //     '.mp4',
  //     '.mkv',
  //   ], onSuccess, (p0) {});
  // } else {
  //   log("Error");
  // }
}

//request for the permission
Future<bool> _requestPermission(Permission permission) async {
  if (await permission.isGranted) {
    return true;
  } else {
    var result = await permission.request();
    if (result == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }
}

//load all folders list also called when the app starting time only
Future<void> loadFolderList() async {
  fetchedFolders.value.clear();
  for (String path in fetchedVideosPath) {
    temp.add(path.substring(
        0, path.lastIndexOf('/'))); //removed video name and add to temp
  }

  fetchedFolders.value = temp.toSet().toList();
}

//Load Folder videos
void getFolderVideos(String path) {
  filteredFolderVideos.value.clear(); //all video list inside the folder
  List<String> matchedVideoPath = []; //videos starting with the folder name
  List<String> splittedMatchedVideoPath =
      []; // so the path which is matched with folder

  var splitted = path.split('/');

  for (dynamic singlePath in fetchedVideosWithInfo.value) {
    if (singlePath.path.startsWith(path)) {
      matchedVideoPath
          .add(singlePath.path); //find the folder matched video path
    }
  }
  log(fetchedVideosPath.length.toString());

  for (String newPath in matchedVideoPath) {
    splittedMatchedVideoPath = newPath.split('/');
    if (splittedMatchedVideoPath[splitted.length].endsWith('.mp4') ||
        splittedMatchedVideoPath[splitted.length].endsWith('.mkv')) {
      filteredFolderVideos.value.add(newPath);
    }
    // filteredFolderVideos.notifyListeners();
  }
  // notify listeners if needed
}

//video info collection
Future<void> getVideoWithInfo() async {
  final videoDB =
      await Hive.openBox<VideoModel>('video_db'); //you have to clear hive
  fetchedVideosWithInfo.value.clear();
  for (int i = 0; i < fetchedVideosPath.length; i++) {
    VideoData? info = await videoInfo.getVideoInfo(fetchedVideosPath[i]);
    final videoModel = VideoModel(
      title: info!.title!,
      path: info.path!,
      height: info.height!.toDouble(),
      width: info.width!.toDouble(),
      fileSize: info.fileSize ?? 0.0,
      duration: info.duration ?? 0.0,
      date: info.date ?? DateTime.now(),
      isFavorite: false,
    );
    videoDB.add(videoModel);

    fetchedVideosWithInfo.value.add(info);
  }
  // fetchedVideosWithInfo.notifyListeners();
}

sortAlphabetical() {
  fetchedVideosWithInfo.value.sort((a, b) {
    return a.title.toLowerCase().compareTo(
          b.title.toLowerCase(),
        );
  });
  // fetchedVideosWithInfo.notifyListeners();
}

sortByDuration() {
  fetchedVideosWithInfo.value.sort((a, b) {
    return a.duration.compareTo(b.duration);
  });
  // fetchedVideosWithInfo.notifyListeners();
}

sortBySize() {
  fetchedVideosWithInfo.value.sort((a, b) {
    return a.fileSize.compareTo(b.fileSize);
  });
  // fetchedVideosWithInfo.notifyListeners();
}

sortByDate() {
  fetchedVideosWithInfo.value.sort((a, b) {
    return a.date.compareTo(b.date);
  });
  // fetchedVideosWithInfo.notifyListeners();
}

Future<void> getFromDB() async {
  final Box<VideoModel> videoDB = await Hive.openBox<VideoModel>('video_db');
  fetchedVideosWithInfo.value.addAll(videoDB.values);
  for (VideoModel obj in fetchedVideosWithInfo.value) {
    temp.add(obj.path.substring(0, obj.path.lastIndexOf('/')));

    log(fetchedVideosWithInfo.value.length.toString());
  }
  fetchedFolders.value = temp.toSet().toList();
}

Future<void> saveUserData(UserModel value) async {
  log(value.toString());
  var userDB = await Hive.openBox<UserModel>('user_db');
  // userDB.put('key1', value);
  userDB.add(value);
  // print(userDB.length);
  log(userDB.get("key1").toString());
}

Future<List<UserModel>> getData() async {
  final Box<UserModel> userDB = await Hive.openBox<UserModel>('user_db');
  // print(userDB.get('user'),);
  log(userDB.length.toString());
  return userDB.values.toList();
}
