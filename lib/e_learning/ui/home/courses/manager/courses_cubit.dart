


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instant1/e_learning/ui/home/courses/Courses.dart';
import 'package:instant1/e_learning/ui/user.dart';

import 'courses_state.dart';

class CoursesCubit extends Cubit<CoursesState> {
  CoursesCubit() : super(CoursesInitial());
  List<CoursesClass> CourseDetails=[];
  List<UserInformation> userInfo=[];
  final fireStore=FirebaseFirestore.instance;

  Future<void> getNotesFromFireStore([String category="",bool getMyCourses=false]) async {
    final userId=FirebaseAuth.instance.currentUser!.uid;
    if(getMyCourses==false){
      if(category==""){
        await fireStore.collection("courses").get().then((value){
          print("=============== start to get the data for all categories");
          CourseDetails.clear();
          for(var doc in value.docs ){
            final c=CoursesClass.fromMap(doc.data());
            CourseDetails.add(c);
          }
          emit(GetCourseDetailsSuccessState());
          //setState(() {});//TODO
        }).catchError((error){
          //emit(GetNoteFailureState(error.toString()));
          print(error);
        });
      }
      else {
        await fireStore.collection("courses").where("category",isEqualTo: category).get().then((value){
          print("=============== start to get the data ${category}");
          CourseDetails.clear();
          for(var doc in value.docs ){
            final c=CoursesClass.fromMap(doc.data());
            CourseDetails.add(c);
          }
          emit(GetCourseDetailsSuccessState());
          //setState(() {});//TODO
        }).catchError((error){
          //emit(GetNoteFailureState(error.toString()));
          print(error);
        });
      }
    }
    else{
      fireStore.collection("users").where("id",isEqualTo: userId).get().then((value) async {
        for(var doc in value.docs ){
          final user=UserInformation.fromMap(doc.data());
          userInfo.add(user);
        }
        CourseDetails.clear();
        for(var courseId in userInfo[0].enrolled){
          await fireStore.collection("courses").where("id",isEqualTo: courseId).get().then((value){
            print("=============== start to get  the data ${courseId}");
            for(var doc in value.docs ){
              print("===========${doc.data()}");
              final c=CoursesClass.fromMap(doc.data());
              CourseDetails.add(c);
            }
          }).catchError((error){
            //emit(GetNoteFailureState(error.toString()));
            print(error);
          });
        }
        emit(GetCourseDetailsSuccessState());
        //print(userInfo[0].enrolled.);
      } );


    }
  }

  Future<void> enrollCourse(String courseId)async{
    List<UserInformation> userInfo=[];
    final fireStore=FirebaseFirestore.instance;
    final userId=FirebaseAuth.instance.currentUser!.uid;
    await fireStore.collection("users").where("id",isEqualTo: userId).get().then((value) async {
      for(var doc in value.docs ){
        final user=UserInformation.fromMap(doc.data());
        userInfo.add(user);
      }
      print(userInfo[0].enrolled);
      if(!userInfo[0].enrolled.contains(courseId)){
        userInfo[0].enrolled.add(courseId);
      }
      print(userInfo[0].enrolled);
      final userCourses=UserInformation(
          userInfo[0].userId,
          userInfo[0].name,
          userInfo[0].phone,
          userInfo[0].email,
          userInfo[0].enrolled
      );
      fireStore.collection("users").doc(userInfo[0].userId).set(userCourses.toMap());
      //print(userInfo[0].enrolled);
    } );
  }


}

