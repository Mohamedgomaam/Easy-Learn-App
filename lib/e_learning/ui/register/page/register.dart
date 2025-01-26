import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:instant1/e_learning/ui/register/manager/register_cubit.dart';
import 'package:instant1/e_learning/ui/register/manager/register_state.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ERegisterScreen extends StatefulWidget {
  const ERegisterScreen({super.key});

  @override
  State<ERegisterScreen> createState() => _ERegisterScreenState();
}

class _ERegisterScreenState extends State<ERegisterScreen> {

  final emailController=TextEditingController();
  final passController=TextEditingController();
  final nameController=TextEditingController();
  final phoneController=TextEditingController();
  final cubit=RegisterCubit();


  @override

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocListener<RegisterCubit, RegisterState>(
        listener: (context, state) => onStateChange(state),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            //decoration: BoxDecoration(
            // image: DecorationImage(
            //   image: AssetImage(
            //   "assets/images/7dc8d1fa24e75a674c1f56736f3b2566.jpeg",
            // ),
            //   fit: BoxFit.fill,
            // )
            //  ),
            color: Colors.grey[200],
            child: Padding(
              padding: EdgeInsets.all(16.sp),
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/Picture1-0kOyEmhQu-transformed.png",
                    width: 56.sp,
                    height: 56.sp,
                  ),
                  Expanded(
                    flex: 7,
                    child: Container(
                      padding:  EdgeInsets.all(20.0.sp),
                      decoration:  BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.sp),
                            topRight: Radius.circular(30.sp),
                            bottomLeft: Radius.circular(30.sp),
                            bottomRight: Radius.circular(30.sp),
                          )
                      ),
                      child: Column(
                        children: [
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
                              keyboardType: TextInputType.number,//this will  show the keyboard with numbers only
                              maxLength: 11,
                              decoration: const  InputDecoration(
                                labelText: 'Phone',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.phone),
                              )
                          ),
                          TextFormField(
                              controller: emailController,
                              textInputAction: TextInputAction.next ,//this mean it will take string in this textFormField
                              keyboardType: TextInputType.emailAddress,//this will  show the keyboard with  letters and numbers and shapes
                              decoration:  const InputDecoration(
                                labelText: 'Email',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.email),

                              )
                          ),
                          SizedBox(height: 13.sp),
                          BlocBuilder<RegisterCubit, RegisterState>(
                            builder: (context, state) {
                              return TextFormField(
                                  controller: passController,
                                  obscureText: cubit.obscureText,//to make it hidde will write it
                                  textInputAction: TextInputAction.done,
                                  decoration:   InputDecoration(
                                      labelText: 'Password',
                                      border: const OutlineInputBorder(),
                                      prefixIcon: const Icon(Icons.lock_outline),
                                      suffixIcon: IconButton(
                                          onPressed: (){
                                            cubit.obscureText = !cubit.obscureText;
                                            cubit.changeObscureText();
                                          },
                                          icon:cubit.obscureText?const Icon(Icons.visibility_off):const Icon(Icons.visibility)
                                      )
                                  )
                              );
                            },
                          ),
                          SizedBox(height: 13.sp),
                          BlocBuilder<RegisterCubit, RegisterState>(
                            builder: (context, state) {
                              return TextFormField(
                                  obscureText: cubit.obscureText,//to make it hidde will write it
                                  textInputAction: TextInputAction.done,
                                  decoration:   InputDecoration(
                                      labelText: 'Confirm Password',
                                      border: const OutlineInputBorder(),
                                      prefixIcon: const Icon(Icons.lock_outline),
                                      suffixIcon: IconButton(
                                          onPressed: (){
                                            cubit.obscureText = !cubit.obscureText;
                                            cubit.changeObscureText();
                                          },
                                          icon:cubit.obscureText?const Icon(Icons.visibility_off):const Icon(Icons.visibility)
                                      )
                                  )
                              );
                            },
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                    onPressed: (){
                                      String email=emailController.text;
                                      String password=passController.text;
                                      String name=nameController.text;
                                      //TODO
                                      cubit.createAccount(email, password,name);
                                      Navigator.pop(context);
                                      //createAccount(email, password); //TODO
                                      print("Register done");
                                    },
                                    style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                                    child: const Text("Register",style: TextStyle(color: Colors.blue),)
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("have an account?"),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Sign In",style: TextStyle(color: Colors.blue),)
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                  const Expanded(flex:1,child: Text(""))
                ],
              ),
            ),
          ),


        ),
      ),
    );
  }

  void onRegisterSuccess() {
    cubit.saveUserData(
        name: nameController.text,
        phone: phoneController.text,
        email: emailController.text
    );
    //saveUserData();//TODO
    Fluttertoast.showToast(msg: "Account Created!");
    Navigator.pop(context);
  }


  void dispose(){
    super.dispose();
    emailController.dispose();
    phoneController.dispose();
    nameController.dispose();
    passController.dispose();
  }

  void onStateChange(RegisterState state) {
    if(state is RegisterSuccessState){
      onRegisterSuccess();
    }
    else if(state is RegisterFailureState){
      Fluttertoast.showToast(msg: state.errorMessage);
    }
  }

}


