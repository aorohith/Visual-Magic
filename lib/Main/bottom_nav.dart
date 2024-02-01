import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:visual_magic/favorites_screen/favorites_screen.dart';
import 'package:visual_magic/home_screen/folders_screen.dart';
import 'package:visual_magic/main/showcase_inherited.dart';
import 'package:visual_magic/RecentScreen/recent_screen.dart';
import 'package:visual_magic/Videos/video_screen.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({Key? key}) : super(key: key);

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  final _key1 = GlobalKey();
  final _key2 = GlobalKey();
  final _key3 = GlobalKey();
  final _key4 = GlobalKey();

  int _page = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  final _pages = [
    const HomeScreen(),
    const RecentScreen(),
    const VideosScreen(),
    const FavoritesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return KeysToBeInherited(
      key1: _key1,
      key2: _key2,
      key3: _key3,
      key4: _key4,
      child: Scaffold(
          bottomNavigationBar: CurvedNavigationBar(
            key: _bottomNavigationKey,
            index: 0,
            height: 60.0,
            items: const [
              Icon(Icons.folder, size: 30),
              Icon(Icons.history, size: 30),
              Icon(Icons.play_circle, size: 30),
              Icon(Icons.favorite, size: 30),
            ],
            color: const Color(0xff2C2C6D),
            buttonBackgroundColor: Colors.white,
            backgroundColor: const Color(0xff060625),
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 600),
            onTap: (index) {
              setState(() {
                _page = index;
              });
            },
            letIndexChange: (index) => true,
          ),
          body: _pages[_page]),
    );
  }
}
