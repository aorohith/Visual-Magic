import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:visual_magic/db/Models/video_model.dart';
import 'package:visual_magic/db/functions.dart';

class UserScreen extends StatefulWidget {
  final String name;
  final String assetImage;

  const UserScreen({
    Key? key,
    required this.assetImage,
    required this.name,
  }) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  File? image;
  String? imagePath;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(widget.name),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              log(image.toString());
              final value = UserModel(
                name: _nameController.text,
                email: _emailController.text,
                image: image,
              );
              saveUserData(value);
            },
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Column(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: image != null
                  ? Image.file(
                      File(imagePath ?? ""),
                      width: 160,
                      height: 160,
                    )
                  : const FlutterLogo(
                      size: 160,
                    ),
            ),
            IconButton(
              iconSize: 30,
              focusColor: Colors.white,
              onPressed: () {
                imagePick();
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: const InputDecoration(border: OutlineInputBorder()),
              controller: _nameController,
            ),
            TextFormField(
              decoration: const InputDecoration(border: OutlineInputBorder()),
              controller: _emailController,
            ),
            const SizedBox(
              height: 20,
            ),
          ]),
        ),
      ),
    );
  }

  Future<void> imagePick() async {
    final temps = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() async {
      imagePath = temps!.path;
    });
  }

  // getDataPressed() {
  //   var values = getData();
  //   log(values);
  // }
}
