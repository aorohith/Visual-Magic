import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:visual_magic/Main/bottom_nav.dart';
import 'package:visual_magic/FetchFiles/load_Data.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
          child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(children: [
          AnimatedSplashScreen.withScreenFunction(
            duration: 2000,
            backgroundColor: Colors.blue,
            splashIconSize: 350,
            splash: Lottie.asset("assets/json/video-loader3.json"),
            screenFunction: () async{
               await splashFetch();
              return BottomNavbar();
            },
          ),
          Positioned(
            left: 105,
            top: 100,
            child: Text(
              "V!SUAL MAGIC",
              style: TextStyle(
                shadows: [
                  Shadow(
                    offset: Offset(1.0, 1.0),
                    blurRadius: 8.0,
                    color: Color.fromARGB(255, 0, 0, 0),
                  )
                ],
                color: Color.fromARGB(255, 233, 226, 226),
                fontWeight: FontWeight.bold,
                fontSize: 35,
              ),
            ),
          )
        ]),
      )),
    );
  }
}