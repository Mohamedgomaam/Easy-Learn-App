import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instant1/e_learning/ui/home/home.dart';
import 'package:instant1/e_learning/ui/home/profile/manager/profile_cubit.dart';
import 'package:instant1/e_learning/ui/home/profile/manager/profile_state.dart';
import 'package:instant1/e_learning/ui/login/page/login.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../ui/forget_password_screen.dart';
import '../../../../../ui/notes/shared.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {

  final userId=FirebaseAuth.instance.currentUser!.uid;
  final profileCubit=ProfileCubit();
  String studentName="";
  String imageURL="";
  final fireStore = FirebaseFirestore.instance;


  @override
  void initState(){
    super.initState();

    fireStore.collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      studentName = value["name"];
      imageURL = value["imageURL"];
    });
    profileCubit.getUserData();

  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => profileCubit,
      child: Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            centerTitle: true,
            title: const Text("Profile",style: TextStyle(color: Colors.black),),
            elevation: 0,
            backgroundColor: Colors.grey[200],
          ),
          body: Column(
            children: [
              BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if(imageURL.isEmpty)
                        InkWell(
                          borderRadius: BorderRadius.circular(50.sp),
                          onTap: (){},
                          child:  CircleAvatar(
                            radius: 38.sp,
                            child: Icon(Icons.person,size: 50.sp,),
                          ),
                        )
                      else
                        CircleAvatar(
                          backgroundImage: NetworkImage(imageURL),
                          radius: 38.sp,
                        ),

                    ],
                  );
                },
              ),
              BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  return Text(
                    studentName,
                    style:  TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold
                    ),
                  );
                },
              ),
              const Text("Student"),
              Padding(
                padding: EdgeInsets.all(18.sp),
                child: InkWell(
                  onTap: (){
                    Navigator.push(
                        context,MaterialPageRoute(builder: (context)=>const ProfileSettings())
                    );
                  },
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.lightGreen[100],
                            shape: BoxShape.circle
                        ),

                        child: IconButton(
                            onPressed: (){
                              Navigator.push(
                                  context,MaterialPageRoute(builder: (context)=>const ProfileSettings())
                              );
                            },
                            icon: Icon(Icons.settings_outlined,color: Colors.green[600],)
                        ),
                      ),
                      SizedBox(width: 20.sp,),
                      Text(
                        "Settings",
                        style: TextStyle(
                            fontSize: 19.sp,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:  EdgeInsets.all(18.sp),
                child: InkWell(
                  onTap: (){
                    saveLogout();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context)=>const ELoginScreen())
                    );
                  },
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.redAccent[100],
                            shape: BoxShape.circle
                        ),

                        child: IconButton(
                            onPressed: (){
                              saveLogout();
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context)=>const EHome())
                              );
                            },
                            icon: Icon(Icons.logout,color: Colors.red[700],)
                        ),
                      ),
                      SizedBox(width: 20.sp,),
                      Text(
                        "Logout",
                        style: TextStyle(
                            fontSize: 19.sp,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
      ),
    );
  }

  void saveLogout() async{
    PreferenceUtils.setBool(prefKeys.loggedIn,false);
  }

}
class ProfileSettings extends StatefulWidget {
  const ProfileSettings({super.key});

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  bool obscureText=true;
  final emailController=TextEditingController();
  final nameController=TextEditingController();
  final phoneController=TextEditingController();
  final auth=FirebaseAuth.instance;
  final fireStore=FirebaseFirestore.instance;
  final storage=FirebaseStorage.instance;
  String imageUrl="";
  bool uploading=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();

  }

  @override
  void dispose(){
    super.dispose();
    emailController.dispose();
    phoneController.dispose();
    nameController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        leading: IconButton(
          icon:  const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: ()  {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text("Profile",style: TextStyle(color: Colors.black),),
        elevation: 0,
        backgroundColor: Colors.grey[200],

      ),
      body: Padding(
        padding:  EdgeInsets.all(16.sp),
        child: Column(
          children: [
            if(imageUrl.isEmpty)
              InkWell(
                borderRadius: BorderRadius.circular(50.sp),
                onTap: ()=>pickImage(),
                child:  CircleAvatar(
                  radius: 38.sp,
                  child: Icon(Icons.person,size: 50.sp,),
                ),
              )
            else
              Stack(
                alignment: Alignment.center,
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(50.sp),
                    onTap: ()=>pickImage(),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(imageUrl),
                      radius: 38.sp,
                    ),
                  ),
                  Visibility(
                      visible: uploading
                      ,child: const CircularProgressIndicator()),
                ],
              ),
            SizedBox(height: 20.sp),
            TextFormField(
                controller: nameController,
                textInputAction: TextInputAction.next ,//this mean it will take string in this textFormField
                keyboardType: TextInputType.text,//this will  show the keyboard with all the letters and numbers
                decoration: const  InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                )
            ),
            SizedBox(height: 13.sp),
            TextFormField(
                controller: phoneController,
                textInputAction: TextInputAction.next ,//this mean it will take string in this textFormField
                keyboardType: TextInputType.number, //this will  show the keyboard with numbers only
                maxLength: 11,
                decoration: const  InputDecoration(
                  labelText: 'Phone',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                )
            ),
            SizedBox(height: 13.sp),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (
                          context) => const ForgetPasswordSceen(fromSettings: true,)), //it will call the screen Register
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.blue,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.sp), // <-- Radius
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("change password"),
                      Icon(Icons.lock)
                    ],
                  )
              ),
            ),
            SizedBox(height: 13.sp),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: (){
                      saveImageUrl();
                      saveUserData();
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                    child: const Text("Update",style: TextStyle(color: Colors.blue),)
                )
            ),

          ],
        ),
      ),


    );
  }

  void saveUserData() {
    final userId=auth.currentUser!.uid;
    final data={
      'name':nameController.text,
      'phone':phoneController.text,
    };
    fireStore.collection("users").doc(userId).update(data);
  }
  void getUserData(){
    fireStore.collection("users").doc(auth.currentUser!.uid)
        .get().then((value){
      updateUi(value.data()!);

    }).catchError((onError){
      print(onError);
    });
  }


  void updateUi(Map<String, dynamic> data) {
    nameController.text=data["name"];
    phoneController.text=data["phone"];
    emailController.text=data['email'];

    imageUrl=data["imageURL"];
    setState(() {

    });

  }

  void uploadImage(File image){
    setState(() {
      uploading=true;
    });
    final userId=auth.currentUser!.uid;
    storage.ref("profileImage/$userId").putFile(image).then((value){
      print("Upload Image=> succeed");
      getImageUrl();
    }).catchError((error){
      setState(() {
        uploading=false;
      });
      print("Upload Image=> $error");
    });
  }

  void getImageUrl(){
    final userId=auth.currentUser!.uid;
    storage.ref("profileImage/$userId").getDownloadURL().then((value){
      print("getImageUrl => $value");
      setState(() {
        imageUrl=value;
        uploading=false;
      });
    }).catchError((error){
      print("Upload Image=> $error");
    });
  }

  void saveImageUrl(){
    final userId=auth.currentUser!.uid;
    fireStore.collection("users").doc(userId).update({
      "imageURL":imageUrl
    });
  }
  void pickImage() async{
    final ImagePicker picker = ImagePicker();
// Pick an image.
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if(file==null){
      return ;
    }
    File imageFile=File(file!.path);
    uploadImage(imageFile);

  }
}


