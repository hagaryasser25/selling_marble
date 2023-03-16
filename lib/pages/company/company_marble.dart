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
import 'package:selling_marble/pages/models/marble_model.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../auth/login.dart';
import '../models/company_model.dart';
import '../models/product_model.dart';
import '../models/users_model.dart';

class CompanyMarble extends StatefulWidget {
  String companyName;
  static const routeName = '/companyMarble';
  CompanyMarble({required this.companyName});

  @override
  State<CompanyMarble> createState() => _CompanyMarbleState();
}

class _CompanyMarbleState extends State<CompanyMarble> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Marble> marbleList = [];
  List<String> keyslist = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchMarble();
  }

  fetchMarble() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = await database
        .reference()
        .child("Marble")
        .child('${widget.companyName}');
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
                            backgroundColor:
                                Color.fromARGB(255, 63, 63, 63), //<-- SEE HERE
                            child: IconButton(
                              icon: Center(
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return AddMarble(
                                    companyName: '${widget.companyName}',
                                  );
                                }));
                              },
                            ),
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
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Text(
                      'الرخام',
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
                    itemCount: marbleList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 15.w, left: 15.w),
                            child: Card(
                              color: HexColor('#ccefc0'),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: SizedBox(
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, right: 15, left: 15, bottom: 10),
                                  child: Row(children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 10.w),
                                      child: Column(
                                        children: [
                                          Text(
                                            '${marbleList[index].name.toString()}',
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            'سعر المتر : ${marbleList[index].price.toString()}',
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              fontSize: 17,
                                            ),
                                          ),
                                          Text(
                                            'الكمية المتاحة : ${marbleList[index].amount.toString()} متر',
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              fontSize: 17,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          super.widget));
                                              base
                                                  .child(marbleList[index]
                                                      .id
                                                      .toString())
                                                  .remove();
                                            },
                                            child: Icon(Icons.delete,
                                                color: Color.fromARGB(
                                                    255, 122, 122, 122)),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                    Container(
                                        width: 110.w,
                                        height: 170.h,
                                        child: Image.network(
                                            '${marbleList[index].imageUrl.toString()}')),
                                  ]),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          )
                        ],
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
