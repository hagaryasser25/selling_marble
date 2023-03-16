import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:selling_marble/pages/admin/add_company.dart';
import 'package:selling_marble/pages/company/add_marble.dart';
import 'package:selling_marble/pages/company/company_marble.dart';
import 'package:selling_marble/pages/models/marble_model.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../auth/login.dart';
import '../models/company_model.dart';
import '../models/product_model.dart';
import '../models/users_model.dart';
import 'company_list.dart';

class CompanyHome extends StatefulWidget {
  static const routeName = '/companyHome';
  const CompanyHome({super.key});

  @override
  State<CompanyHome> createState() => _CompanyHomeState();
}

class _CompanyHomeState extends State<CompanyHome> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Marble> marbleList = [];
  List<String> keyslist = [];
  late Users currentUser;

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  getUserData() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database
        .reference()
        .child("users")
        .child(FirebaseAuth.instance.currentUser!.uid);

    final snapshot = await base.get();
    setState(() {
      currentUser = Users.fromSnapshot(snapshot);
      print(currentUser.fullName);
    });
  }

  fetchMarble() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = await database
        .reference()
        .child("Marble")
        .child('${currentUser.fullName}');
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Marble p = Marble.fromJson(event.snapshot.value);
      marbleList.add(p);
      keyslist.add(event.snapshot.key.toString());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
          body: Column(
            children: [
              Container(
                height: 150.h,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 34, 34, 34),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 40.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 20.w),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.white,
                            backgroundImage:
                                AssetImage('assets/images/icon.png'),
                          ),
                          SizedBox(
                            width: 250.w,
                          ),
                          CircleAvatar(
                            radius: 20,
                            backgroundColor:
                                Color.fromARGB(255, 63, 63, 63), //<-- SEE HERE
                            child: IconButton(
                              icon: Center(
                                child: Icon(
                                  Icons.logout,
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text('تأكيد'),
                                        content: Text(
                                            'هل انت متأكد من تسجيل الخروج'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              FirebaseAuth.instance.signOut();
                                              Navigator.pushNamed(
                                                  context, LoginPage.routeName);
                                            },
                                            child: Text('نعم'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('لا'),
                                          ),
                                        ],
                                      );
                                    });
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Text(
                      'الصفحة الرئيسية',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Image.asset(
                'assets/images/t.png',
                width: double.infinity,
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                'الخدمات المتاحة',
                style: TextStyle(fontSize: 27, color: HexColor('#32486d')),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.only(right: 20.w),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return CompanyMarble(
                            companyName: '${currentUser.fullName}',
                          );
                        }));
                      },
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(right: 10.w, left: 10.w),
                          child: Center(
                            child: Column(children: [
                              SizedBox(
                                height: 20.h,
                              ),
                              Image.asset('assets/images/box.png',
                                  width: 120.w, height: 120.h),
                              SizedBox(
                                height: 10.h,
                              ),
                              FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  "أضافة رخام",
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 30.w,
                    ),
                    InkWell(
                      onTap: () {
                        
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return CompanyList(
                            name: '${currentUser.fullName}',
                          );
                        }));
                        
                      },
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(right: 10.w, left: 10.w),
                          child: Center(
                            child: Column(children: [
                              SizedBox(
                                height: 20.h,
                              ),
                              Image.asset('assets/images/list.png',
                                  width: 120.w, height: 120.h),
                              SizedBox(
                                height: 10.h,
                              ),
                              FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  'طلبيات الشراء',
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
