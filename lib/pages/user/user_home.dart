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
import 'package:selling_marble/pages/user/user_marble.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../auth/login.dart';
import '../models/company_model.dart';
import '../models/product_model.dart';
import '../models/users_model.dart';

class UserHome extends StatefulWidget {
  static const routeName = '/userHome';
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Company> companyList = [];
  List<String> keyslist = [];
  late Users currentUser;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchCompany();
  }

   @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  void fetchCompany() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("company");
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Company p = Company.fromJson(event.snapshot.value);
      companyList.add(p);
      keyslist.add(event.snapshot.key.toString());
      print(keyslist);
      setState(() {});
    });
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

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) => Scaffold(
            body: Column(children: [
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
                      'شركات الرخام',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 20.w, left: 20.w),
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      Container(
                        child: StaggeredGridView.countBuilder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.only(
                            left: 15.w,
                            right: 15.w,
                            bottom: 15.h,
                          ),
                          crossAxisCount: 6,
                          itemCount: companyList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return UserMarble(
                                      companyName: '${companyList[index].name}',
                                    );
                                  }));
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        right: 10.w, left: 10.w),
                                    child: Center(
                                      child: Column(children: [
                                        Image.asset('assets/images/company.jpg',
                                            width: 155.w, height: 155.h),
                                        FittedBox(
                                          fit: BoxFit.fitWidth,
                                          child: Text(
                                            '${companyList[index].name}',
                                            style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        FittedBox(
                                          fit: BoxFit.fitWidth,
                                          child: Text(
                                            '${companyList[index].phoneNumber}',
                                            style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ]),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          staggeredTileBuilder: (int index) =>
                              new StaggeredTile.count(3, index.isEven ? 3 : 3),
                          mainAxisSpacing: 40.0,
                          crossAxisSpacing: 5.0.w,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 100.h)
            ]),
          ),
        ));
  }
}
