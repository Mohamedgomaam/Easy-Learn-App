
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instant1/e_learning/ui/lessons.dart';
import 'package:instant1/e_learning/ui/user.dart';


import 'lessons_state.dart';

class LessonsCubit extends Cubit<LessonsState> {
  LessonsCubit() : super(LessonsInitial());
  List<Lesson> lessons=[];
  final fireStore=FirebaseFirestore.instance;
  List<UserInformation> userInfo=[];
  bool enrolled=false;
  final userId=FirebaseAuth.instance.currentUser!.uid;
  //courseId
  //TODO


  Future<void> getLessonsFromFireStore({required String courseId}) async {
    fireStore.collection("users").where("id",isEqualTo: userId).get().then((value) {
      for(var doc in value.docs ){
        final user=UserInformation.fromMap(doc.data());
        userInfo.add(user);
      }
      for(var cId in userInfo[0].enrolled){
        if(courseId==cId){
          enrolled=true;
        }
      }
    });
    print(courseId);
    await fireStore.collection("lesssons").where("courseId",isEqualTo: courseId).get().then((value){
      lessons.clear();
      for(var doc in value.docs ){
        final c=Lesson.fromMap(doc.data());
        lessons.add(c);
      }

      int x=int.parse(lessons[0].name.substring(7));
      lessons.sort((a, b) => int.parse(a.name.substring(7) ).compareTo(int.parse(b.name.substring(7))));

    }).catchError((error){
      print(error);
    });
    emit(GetLessonsSuccessState());
  }
}
