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
import 'package:selling_marble/pages/user/send_complain.dart';
import 'package:selling_marble/pages/user/user_replays.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../auth/login.dart';
import '../models/company_model.dart';
import '../models/product_model.dart';
import '../models/users_model.dart';

class UserComplain extends StatefulWidget {
  static const routeName = '/userComplain';
  const UserComplain({super.key});

  @override
  State<UserComplain> createState() => _UserComplainState();
}

class _UserComplainState extends State<UserComplain> {
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
                        ],
                      ),
                    ),
                    Text(
                      'الشكاوى',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
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
                        Navigator.pushNamed(context, SendComplain.routeName);
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
                              Image.asset('assets/images/send.png',
                                  width: 120.w, height: 120.h),
                              SizedBox(
                                height: 10.h,
                              ),
                              FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  "ارسال شكوى",
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
                        Navigator.pushNamed(context, UserReplays.routeName);
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
                              Image.asset('assets/images/reply.png',
                                  width: 120.w, height: 120.h),
                              SizedBox(
                                height: 10.h,
                              ),
                              FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  'الردود على الشكاوى',
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
