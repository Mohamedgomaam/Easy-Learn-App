import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instant1/e_learning/ui/login/manager/login_state.dart';

import '../../../../ui/notes/shared.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  bool obscureText=true;

  void changeObscureText(){
    emit(ObscureText());
  }


  void login({
    required String email,
    required String password,
  }){

    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    )
        .then((value) {
      savedLoggedIn();

      emit(LoginSuccessState());

    }).catchError((error){
      if(error is FirebaseAuthException){
        if (error.code == 'user-not-found') {
          emit(LoginFailureState("No user found for that email."));
          //displayToast('No user found for that email.');//TODO
        } else if (error.code == 'wrong-password') {
          emit(LoginFailureState("Wrong password provided for that user."));
          //displayToast('Wrong password provided for that user.');//TODO
        }
        else if (error.code == 'too-many-request') {
          emit(LoginFailureState("We have blocked all requests from this device due to unusual activity. Try again later."));
          //displayToast('We have blocked all requests from this device due to unusual activity. Try again later.');//TODO
        }
      }
      else{
        emit(LoginFailureState(error.toString()));
        //displayToast(error.toString());//TODO
      }
    });

    // if ( email == "Mohamed@gmail.com" && pass == "123456789"){
    //   Navigator.pushReplacement(context,
    //       MaterialPageRoute(
    //       builder: (context)=>HomeScreen(),)
    // );
    // }
    // else{
    //
    //   //displaySnackBar("Wrong Email or Password");
    // }


  }
  void savedLoggedIn() async{
    PreferenceUtils.setBool(prefKeys.loggedIn, true);

  }
}
