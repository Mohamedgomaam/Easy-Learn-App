

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instant1/e_learning/ui/home/home_screen/manager/home_state.dart';


class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  final fireStore=FirebaseFirestore.instance;
  String studentName="";

  List<String> name=[" "] ;

  Future<void> getName()  async {
   await fireStore.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) {
    print("=======================================");
    print(value["name"]);
    studentName=value["name"];
    name.add(value["name"]);
    emit(Name());
  });

  }
}

