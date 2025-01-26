import 'package:flutter/material.dart';
import 'package:instant1/e_learning/ui/home/courses/page/Courses.dart';
import 'package:instant1/e_learning/ui/home/home_screen/page/EHome_Screen.dart';
import 'package:instant1/e_learning/ui/home/profile/page/my_profile.dart';
import 'package:instant1/e_learning/ui/home/search_course/page/search_course.dart';

import 'my_courses/page/my_course.dart';

class EHome extends StatefulWidget {
  const EHome({super.key});

  @override
  State<EHome> createState() => _EHomeState();
}

class _EHomeState extends State<EHome> {
  int onPress=0;
  final screens=[
    const EHomeScreen(),
    const Courses(),
    const SearchCourse(),
    const MyCourses(),
    const MyProfile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 0,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black54,
        currentIndex: onPress,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "",
              backgroundColor: Colors.white
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.video_camera_back_sharp),
              label: "",
              backgroundColor: Colors.white
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "",
              backgroundColor: Colors.white
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.video_collection),
              label: "",
              backgroundColor: Colors.white
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "",
              backgroundColor: Colors.white
          ),
        ],
        onTap: (value){
          onPress=value;
          setState(() {});
        },

      ),
      backgroundColor: Colors.white,
      body: screens[onPress],

    );
  }
}
