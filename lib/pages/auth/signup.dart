// ignore_for_file: prefer_const_constructors

import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:ndialog/ndialog.dart';
import 'package:selling_marble/pages/company/company_home.dart';

import '../../components/my_button.dart';
import '../../components/my_textField.dart';
import '../admin/admin_bottom.dart';

class SignUpPage extends StatefulWidget {
  static const routeName = '/signUpPage';
  SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // text editing controllers
  final passwordController = TextEditingController();

  final emailController = TextEditingController();

  var phoneNumberController = TextEditingController();
  var nameController = TextEditingController();

  double _sigmaX = 5;
  // from 0-10
  double _sigmaY = 5;
  // from 0-10
  double _opacity = 0.2;

  double _width = 350;

  double _height = 300;

  final _formKey = GlobalKey<FormState>();

  // sign user in method
  void signUserIn() {
    if (_formKey.currentState!.validate()) {
      print('valid');
    } else {
      print('not valid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
          backgroundColor: Colors.grey[300],
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/images/marble.png',
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    fit: BoxFit.cover,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.26),
                      Padding(
                        padding: EdgeInsets.only(right: 75.w),
                        child: const Text("تسجيل الدخول",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                              sigmaX: _sigmaX, sigmaY: _sigmaY),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(0, 0, 0, 1)
                                    .withOpacity(_opacity),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30))),
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: MediaQuery.of(context).size.height * 0.49,
                            child: Form(
                              key: _formKey,
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    SizedBox(
                                      height: 65.h,
                                      child: MyTextField(
                                        controller: nameController,
                                        hintText: 'الأسم',
                                        obscureText: false,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    SizedBox(
                                      height: 65.h,
                                      child: MyTextField(
                                        controller: phoneNumberController,
                                        hintText: 'رقم الهاتف',
                                        obscureText: false,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    SizedBox(
                                      height: 65.h,
                                      child: MyTextField(
                                        controller: emailController,
                                        hintText: 'البريد الألكترونى',
                                        obscureText: false,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    SizedBox(
                                      height: 65.h,
                                      child: MyPasswordTextField(
                                        controller: passwordController,
                                        hintText: 'كلمة المرور',
                                        obscureText: true,
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        SizedBox(
                                          height: 60.h,
                                          child: MyButtonAgree(
                                            text: "انشاء حساب",
                                            onTap: () async {
                                              var name =
                                                  nameController.text.trim();
                                              var phoneNumber =
                                                  phoneNumberController.text
                                                      .trim();
                                              var email =
                                                  emailController.text.trim();
                                              var password = passwordController
                                                  .text
                                                  .trim();

                                              if (name.isEmpty ||
                                                  email.isEmpty ||
                                                  password.isEmpty ||
                                                  phoneNumber.isEmpty) {
                                                MotionToast(
                                                        primaryColor:
                                                            Colors.blue,
                                                        width: 300,
                                                        height: 50,
                                                        position:
                                                            MotionToastPosition
                                                                .center,
                                                        description: Text(
                                                            "please fill all fields"))
                                                    .show(context);

                                                return;
                                              }

                                              if (password.length < 6) {
                                                // show error toast
                                                MotionToast(
                                                        primaryColor:
                                                            Colors.blue,
                                                        width: 300,
                                                        height: 50,
                                                        position:
                                                            MotionToastPosition
                                                                .center,
                                                        description: Text(
                                                            "Weak Password, at least 6 characters are required"))
                                                    .show(context);

                                                return;
                                              }

                                              ProgressDialog progressDialog =
                                                  ProgressDialog(context,
                                                      title: Text('Signing Up'),
                                                      message:
                                                          Text('Please Wait'));
                                              progressDialog.show();

                                              try {
                                                FirebaseAuth auth =
                                                    FirebaseAuth.instance;

                                                UserCredential userCredential =
                                                    await auth
                                                        .createUserWithEmailAndPassword(
                                                  email: email,
                                                  password: password,
                                                );
                                                User? user =
                                                    userCredential.user;

                                                if (userCredential.user !=
                                                    null) {
                                                  DatabaseReference userRef =
                                                      FirebaseDatabase.instance
                                                          .reference()
                                                          .child('users');

                                                  String uid =
                                                      userCredential.user!.uid;
                                                  int dt = DateTime.now()
                                                      .millisecondsSinceEpoch;

                                                  await userRef.child(uid).set({
                                                    'name': name,
                                                    'email': email,
                                                    'password': password,
                                                    'uid': uid,
                                                    'dt': dt,
                                                    'phoneNumber': phoneNumber,
                                                  });

                                                  Navigator.canPop(context)
                                                      ? Navigator.pop(context)
                                                      : null;
                                                } else {
                                                  MotionToast(
                                                          primaryColor:
                                                              Colors.blue,
                                                          width: 300,
                                                          height: 50,
                                                          position:
                                                              MotionToastPosition
                                                                  .center,
                                                          description:
                                                              Text("failed"))
                                                      .show(context);
                                                }
                                                progressDialog.dismiss();
                                              } on FirebaseAuthException catch (e) {
                                                progressDialog.dismiss();
                                                if (e.code ==
                                                    'email-already-in-use') {
                                                  MotionToast(
                                                          primaryColor:
                                                              Colors.blue,
                                                          width: 300,
                                                          height: 50,
                                                          position:
                                                              MotionToastPosition
                                                                  .center,
                                                          description: Text(
                                                              "email is already exist"))
                                                      .show(context);
                                                } else if (e.code ==
                                                    'weak-password') {
                                                  MotionToast(
                                                          primaryColor:
                                                              Colors.blue,
                                                          width: 300,
                                                          height: 50,
                                                          position:
                                                              MotionToastPosition
                                                                  .center,
                                                          description: Text(
                                                              "password is weak"))
                                                      .show(context);
                                                }
                                              } catch (e) {
                                                progressDialog.dismiss();
                                                MotionToast(
                                                        primaryColor:
                                                            Colors.blue,
                                                        width: 300,
                                                        height: 50,
                                                        position:
                                                            MotionToastPosition
                                                                .center,
                                                        description: Text(
                                                            "something went wrong"))
                                                    .show(context);
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
