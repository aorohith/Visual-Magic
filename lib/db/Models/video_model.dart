import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
part 'video_model.g.dart';

@HiveType(typeId: 1)
class VideoModel {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String path;

  @HiveField(2)
  final double height;

  @HiveField(3)
  final double width;

  @HiveField(4)
  final double fileSize;

  @HiveField(5)
  final double duration;

  @HiveField(6)
  final DateTime date;

  @HiveField(7)
  static final folderPaths = [];

  @HiveField(8)
  final bool isFavorite;

  VideoModel({
    required this.title,
    required this.path,
    required this.height,
    required this.width,
    required this.fileSize,
    required this.duration,
    required this.date,
    required this.isFavorite,
  });
}

@HiveType(typeId: 2)
class UserModel {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final File? image;

  UserModel({
    required this.name,
    required this.email,
    required this.image,
  });
}
