import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instant1/e_learning/ui/register/manager/register_state.dart';

import '../../../../ui/notes/shared.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  bool obscureText=true;
  final auth=FirebaseAuth.instance;
  final fireStore=FirebaseFirestore.instance;

  void changeObscureText(){
    emit(ObscureText());
  }


  void createAccount(String email,String password,String name)async{

    // FirebaseAuth.instance.signInWithEmailAndPassword(
    //     email: email,
    //     password: password
    // ).then((value) => {
    //
    // }).catchError((error){
    //
    // });


    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      saveUserData(name: name, email:email, phone: password ,);
      emit(RegisterSuccessState());
      //onRegisterSuccess(); //TODO
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        emit(RegisterFailureState("The password provided is too weak."));
        //Fluttertoast.showToast(msg: "The password provided is too weak.");//TODO
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        emit(RegisterFailureState("The account already exists for that email."));
        //Fluttertoast.showToast(msg: "The account already exists for that email.");//TODO
      }
    } catch (e) {
      print(e);
      emit(RegisterFailureState(e.toString()));
      //Fluttertoast.showToast(msg: e.toString());//TODO
    }
  }

  void saveLogin() async{
    PreferenceUtils.setBool(prefKeys.loggedIn,true);
  }

  void saveUserData({
    required String name,
    required String phone,
    required String email,
  }) {
    final userId=FirebaseAuth.instance.currentUser!.uid;
    final data={
      "id":userId,
      'name':name,
      'phone':phone,
      "email":email,
      'imageURL':"https://i.pngimg.me/thumb/f/720/m2i8m2A0K9H7N4m2.jpg",
      "enrolled":[""]

    };
    //print("current user id =====================>>>>>>>>>>>>>>>>>>>>>${userId}");
    //firestore.collection("users").doc(userId).set(note.toMap())
    fireStore.collection("users").doc(userId).set(data);
    saveLogin();
    //emit(RegisterSuccessState());
  }

}
