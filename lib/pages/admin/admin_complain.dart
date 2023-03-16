import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../models/complains_model.dart';
import '../models/essay_model.dart';
import 'admin_replay.dart';
import 'essay_details.dart';

class AdminComplain extends StatefulWidget {
  static const routeName = '/adminComplain';
  const AdminComplain({super.key});

  @override
  State<AdminComplain> createState() => _AdminComplainState();
}

class _AdminComplainState extends State<AdminComplain> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Complains> complainsList = [];
  List<String> keyslist = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchComplains();
  }

  @override
  void fetchComplains() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("userComplains");
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Complains p = Complains.fromJson(event.snapshot.value);
      complainsList.add(p);
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
                                AssetImage('assets/images/essay.png'),
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
              Expanded(
                flex: 8,
                child: ListView.builder(
                  itemCount: complainsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, right: 15, left: 15, bottom: 10),
                              child: Column(children: [
                                Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      'الشكوى : ${complainsList[index].description.toString()}',
                                      style: TextStyle(fontSize: 17),
                                    )),
                                Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      'كود المشتكى: ${complainsList[index].userUid.toString()}',
                                      style: TextStyle(fontSize: 17),
                                    )),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  children: [
                                    ConstrainedBox(
                                      constraints: BoxConstraints.tightFor(
                                          width: 120.w, height: 35.h),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Color.fromARGB(255, 71, 233, 133),
                                        ),
                                        child: Text('الرد على الشكوى'),
                                        onPressed: () async {
                                          
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return AdminReplay(
                                              complain:
                                                  '${complainsList[index].description.toString()}',
                                              uid:
                                                  '${complainsList[index].userUid.toString()}',
                                            );
                                          }));
                                          
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: 50.w,
                                    ),
                                    ConstrainedBox(
                                      constraints: BoxConstraints.tightFor(
                                          width: 120.w, height: 35.h),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Color.fromARGB(255, 71, 233, 133),
                                        ),
                                        child: Text('مسح الشكوى'),
                                        onPressed: () async {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          super.widget));
                                          base
                                              .child(complainsList[index]
                                                  .id
                                                  .toString())
                                              .remove();
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              ]),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        )
                      ],
                    );
                  },
                ),
              ),
            ]),
          ),
        ));
  }
}
