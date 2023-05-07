import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:selling_marble/pages/admin/add_company.dart';
import 'package:selling_marble/pages/admin/add_types.dart';
import 'package:selling_marble/pages/admin/admin_bottom.dart';
import 'package:selling_marble/pages/admin/admin_home.dart';
import 'package:selling_marble/pages/auth/admin_login.dart';
import 'package:selling_marble/pages/auth/company_login.dart';
import 'package:selling_marble/pages/auth/login.dart';
import 'package:selling_marble/pages/auth/signup.dart';
import 'package:selling_marble/pages/company/company_home.dart';
import 'package:selling_marble/pages/user/send_complain.dart';
import 'package:selling_marble/pages/user/user_bottom.dart';
import 'package:selling_marble/pages/user/user_marble.dart';
import 'package:selling_marble/pages/user/user_replays.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: FirebaseAuth.instance.currentUser == null
          ? LoginPage()
          : FirebaseAuth.instance.currentUser!.email == 'admin@gmail.com'
              ? const AdminBottom()
              : FirebaseAuth.instance.currentUser!.displayName == 'شركة'
                  ? const CompanyHome()
                  : UserBottom(),
      routes: {
        SignUpPage.routeName: (ctx) => SignUpPage(),
        LoginPage.routeName: (ctx) => LoginPage(),
        AdminHome.routeName: (ctx) => AdminHome(),
        AdminLogin.routeName: (ctx) => AdminLogin(),
        CompanyLogin.routeName: (ctx) => CompanyLogin(),
        CompanyHome.routeName: (ctx) => CompanyHome(),
        AdminBottom.routeName: (ctx) => AdminBottom(),
        UserBottom.routeName: (ctx) => UserBottom(),
        AddCompany.routeName: (ctx) => AddCompany(),
        SendComplain.routeName: (ctx) => SendComplain(),
        UserReplays.routeName: (ctx) => UserReplays(),
        AddTypes.routeName: (ctx) => AddTypes(),
      },
    );
  }
}
