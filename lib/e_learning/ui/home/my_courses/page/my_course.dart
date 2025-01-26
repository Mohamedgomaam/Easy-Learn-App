import 'package:flutter/material.dart';
import 'package:instant1/e_learning/ui/home/courses/page/Courses.dart';

class MyCourses extends StatefulWidget {
  const MyCourses({super.key});

  @override
  State<MyCourses> createState() => _MyCoursesState();
}

class _MyCoursesState extends State<MyCourses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Courses(
        getMyCourses: true,
      ),

    );
  }
}
