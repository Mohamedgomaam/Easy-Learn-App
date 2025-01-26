import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:instant1/e_learning/ui/login/manager/login_cubit.dart';
import 'package:instant1/e_learning/ui/login/manager/login_state.dart';
import 'package:instant1/e_learning/ui/register/page/register.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../ui/forget_password_screen.dart';
import '../../../../ui/notes/ui/home/page/home_screen.dart';
import '../../home/home.dart';

class ELoginScreen extends StatefulWidget {
  const ELoginScreen({super.key});

  @override
  State<ELoginScreen> createState() => _LIState();
}

class _LIState extends State<ELoginScreen> {
  final cubit = LoginCubit();

  //define Form validation
  final formKey = GlobalKey<FormState>();


  final emailController = TextEditingController();
  final passController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            onLoginSuccess();
          }
          else if (state is LoginFailureState) {
            displayToast(state.errorMessage);
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            decoration:  BoxDecoration(
                color: Colors.grey[200],
                // image: DecorationImage(image: AssetImage(
                //   "assets/images/7dc8d1fa24e75a674c1f56736f3b2566.jpeg",
                // ),
                //   fit: BoxFit.fill,
                // )
            ),
            child: Padding(
              padding:  EdgeInsets.all(10.sp),
              child: Column(
                children: [
                  SizedBox(height: 35.sp),
                  Image.asset(
                    "assets/images/Picture1-0kOyEmhQu-transformed.png",
                    width: 56.sp,
                    height: 56.sp,
                  ),
                  SizedBox(height: 8.sp,),
                  Expanded(
                    flex: 3,
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
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.email_outlined),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Email Required";
                                }
                                if (!value.contains("@") ||
                                    !value.contains(".")) {
                                  return "Invalid Email";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 12.sp,),
                            BlocBuilder<LoginCubit, LoginState>(
                              buildWhen: (previous, current) {
                                return current is ObscureText;
                              },
                              builder: (context, state) {
                                return TextFormField(
                                  controller: passController,
                                  obscureText: cubit.obscureText,
                                  decoration: InputDecoration(
                                      labelText: 'Password',
                                      border: const OutlineInputBorder(),
                                      prefixIcon: const Icon(Icons.lock),
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            cubit.obscureText = !cubit.obscureText;
                                            cubit.changeObscureText();
                                          },
                                          icon: cubit.obscureText ? const Icon(
                                              Icons.visibility_off) : const Icon(
                                              Icons.visibility)
                                      )
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Password required";
                                    }
                                    if (value.length < 5) {
                                      return "Password must be at least 6 Characters";
                                    }
                                    return null;
                                  },
                                );
                              },
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (
                                      context) => const ForgetPasswordSceen(fromSettings: false,)), //it will call the screen Register
                                );
                              },
                              child: Container(
                                alignment: Alignment.bottomRight,
                                padding: EdgeInsets.all(13.sp),
                                child: const Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                      color: Colors.black
                                  ),
                                ),
                              ),
                            ),

                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(

                                    onPressed: () {
                                      login();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: const StadiumBorder(),
                                    ),
                                    child: const Text("Log In",style: TextStyle(color: Colors.blue),),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Don't Have account?"),
                                TextButton(
                                    onPressed: () {
                                      NavToRegisterScreen(context);
                                    },
                                    child: const Text("Register",style: TextStyle(color: Colors.blue),)
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Expanded(
                      flex: 2,
                      child: Text(" ")
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void login() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    String email = emailController.text;
    String password = passController.text;
    cubit.login(email: email, password: password);
  }

  void onLoginSuccess() {
    Navigator.pushReplacement(context,
      MaterialPageRoute(
        builder: (context) => const EHome(),
      ),
    );
  }

  void displaySnackBar(String message) {
    var snackBar = SnackBar(
      content: Text(message)
      ,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void displayToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

}

NavToRegisterScreen(BuildContext context){
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context)=>const ERegisterScreen()),//it will call the screen Register
  );
}