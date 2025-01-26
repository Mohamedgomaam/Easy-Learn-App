import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instant1/e_learning/ui/home/profile/manager/profile_state.dart';
import 'package:instant1/e_learning/ui/user.dart';
import 'package:meta/meta.dart';


class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  late List<UserInformation> userInfo=[];
  final fireStore=FirebaseFirestore.instance;

  Future<void>  getUserData() async{
    final userId=FirebaseAuth.instance.currentUser!.uid;
    await fireStore.collection("users").where("id",isEqualTo: userId).get().then((value) async {
      print("valuuuuuuuuuuuuueee${value.docs}");
      for (var doc in value.docs) {
        final user = UserInformation.fromMap(doc.data());
        userInfo.add(user);
        print("=======  === ========== >${this.userInfo}");
      }
      //await Future<void>.delayed(const Duration(milliseconds: 50));
      emit(GetProfileSuccessState());
      print("1st=====");
    }).catchError((error){
      print(error);
      emit(GetProfileFailureState());
    });
  }
}
