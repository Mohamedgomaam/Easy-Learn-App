import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instant1/e_learning/ui/home/courses/page/Courses.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../manager/search_cubit.dart';
import '../manager/search_state.dart';

class SearchCourse extends StatefulWidget {
  const SearchCourse({super.key});

  @override
  State<SearchCourse> createState() => _SearchCourseState();
}

class _SearchCourseState extends State<SearchCourse> {
  final TextEditingController searchController = TextEditingController();
  String category = "";
  bool x=true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.all(19.sp),
        color: Colors.grey[200],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 23.sp,),
            SearchBar(
              hintText: "Category",
              backgroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 255, 255, 255)
              ),
              controller: searchController,
              leading: const Icon(Icons.search),
              onChanged: (String value) {
                search();
                //print();
                //print('value: $value');
                //print(searchController.text.toString());
                //cubit.sear();
                category=searchController.text.toString().trim();

              },
            ),

            SizedBox(height:  15.sp),
            x?const Text(" "):getAvailableCourses(),
            x?getAvailableCourses():const Text(" "),
          ],
        ),
      ),
    );
  }
  Widget getAvailableCourses() {
    print("rebuild============");
    return Expanded(
      child: Courses(
        category: category,
        fromSearch: true,
      ),
    );
}

  void search() {
    x=!x;
    setState(() {
    });
  }
}
