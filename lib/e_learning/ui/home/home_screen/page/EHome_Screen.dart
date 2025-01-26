import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instant1/e_learning/ui/home/home_screen/manager/home_cubit.dart';
import 'package:instant1/e_learning/ui/home/home_screen/manager/home_state.dart';
import 'package:instant1/ui/notes/shared.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../courses/page/Courses.dart';


class EHomeScreen extends StatefulWidget {
  const EHomeScreen({super.key});

  @override
  State<EHomeScreen> createState() => _EHomeScreenState();
}

class _EHomeScreenState extends State<EHomeScreen> {
  bool clicked = false;
  final cubit = HomeCubit();
  String category = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //cubit.start();
    print("cubit valuessssssssssssssssssssssssss");
    cubit.getName();
    print(cubit.name);
    print("cubit valuessssssssssssssssssssssssss =============>>>>>>${FirebaseAuth.instance.currentUser!.uid}");
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: Scaffold(

          body: clicked? Courses(category: category, fromHome: true,) : showHome()
      ),
    );
  }

  Widget showHome() {
    return BlocBuilder<HomeCubit, HomeState>(
    builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[200],
          elevation: 0,
          title: Row(
            children: [
              Text(
                'Hi, ',
                style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue
                ),
              ),
              Text(
                cubit.studentName,
                style:  TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue
                ),
              ),

            ],
          ),
        ),
        body: Container(
          padding:  EdgeInsets.all(11.sp),
          decoration: BoxDecoration(
              color: Colors.grey[200]
          ),
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
                padding:  EdgeInsets.all(12.sp),
                decoration:   BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(23.sp),
                      topRight: Radius.circular(23.sp),
                      bottomLeft: Radius.circular(23.sp),
                      bottomRight: Radius.circular(23.sp),
                    )
                ),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/Study-area.jpg",
                      width: 60.sp,
                      height: 50.sp,
                    ),
                    SizedBox(width: 15.sp,),
                    Column(
                      children: [
                         Text(
                          "Lets Learn",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp
                          ),
                        ),
                         Text(
                          "More",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp
                          ),
                        ),
                        TextButton(onPressed: () {

                        }, child: const Text(
                            "get started",
                          style: TextStyle(
                            color: Colors.blue
                          ),
                        )
                        ),

                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 13.sp,),
              Text(
                "Categories",
                style: TextStyle(
                    fontSize: 21.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue
                ),
              ),
              SizedBox(height: 13.sp,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {

                      clicked = true;
                      category = "programming";
                      setState(() {

                      });
                    },
                    child: Container(
                      decoration:  BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(23.sp),
                            topRight: Radius.circular(23.sp),
                            bottomLeft: Radius.circular(23.sp),
                            bottomRight: Radius.circular(23.sp),
                          )
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 16.sp,),
                          Text(
                            "Programming",
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue
                            ),
                          ),
                          Image.asset(
                            "assets/images/ProgrammingIllustration-transformed.png",
                            width: 54.sp,
                            height:53.sp,
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      clicked = true;
                      category = "accounting";
                      setState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(23.sp),
                            topRight: Radius.circular(23.sp),
                            bottomLeft: Radius.circular(23.sp),
                            bottomRight: Radius.circular(23.sp),
                          )
                      ),
                      padding: EdgeInsets.all(15.sp),
                      child: Column(
                        children: [
                          Text(
                            "Accounting",
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue
                            ),
                          ),
                          SizedBox(height: 10.sp,),
                          Image.asset(
                            "assets/images/accounting-icon-vector.jpg",
                            width: 51.sp,
                            height: 50.sp,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 13.sp,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      clicked = true;
                      category = "fitness";
                      setState(() {});
                    },
                    child: Container(
                      decoration:  BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(23.sp),
                            topRight: Radius.circular(23.sp),
                            bottomLeft: Radius.circular(23.sp),
                            bottomRight: Radius.circular(23.sp),
                          )
                      ),
                      padding:  EdgeInsets.all(15.sp),
                      child: Column(
                        children: [
                          Text(
                            "Fitness",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 19.sp,
                                color: Colors.blue
                            ),
                          ),
                          SizedBox(height: 15.sp,),
                          Image.asset(
                            "assets/images/istockphoto-1331186720-612x612.jpg",
                            width: 50.sp,
                            height: 50.sp,
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      clicked = true;
                      category = "language";
                      setState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(23.sp),
                            topRight: Radius.circular(23.sp),
                            bottomLeft: Radius.circular(23.sp),
                            bottomRight: Radius.circular(23.sp),
                          )
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 14.sp,),
                          Text(
                            "Language",
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue
                            ),
                          ),
                          Image.asset(
                            "assets/images/360_F_202940027_cOHoOUcxdaUU2uiUI4wNeyEjmE9mJ8cm-transformed.png",
                            width: 55.sp,
                            height: 55.sp,
                          ),
                        ],
                      ),
                    ),
                  ),

                ],
              ),

            ],
          ),
        ),

      );
    },
    );
  }
  void saveLogout() async{
    PreferenceUtils.setBool(prefKeys.loggedIn,false);
  }
}

