import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:selling_marble/pages/admin/add_company.dart';
import 'package:selling_marble/pages/admin/add_types.dart';
import 'package:selling_marble/pages/models/types_model.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../models/company_model.dart';
import '../models/product_model.dart';
import 'admin_details.dart';

class AdminMarble extends StatefulWidget {
  static const routeName = '/adminMarble';
  const AdminMarble({super.key});

  @override
  State<AdminMarble> createState() => _AdminMarbleState();
}

class _AdminMarbleState extends State<AdminMarble> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Types> typesList = [];
  List<String> keyslist = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchTypes();
  }

  void fetchTypes() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("types");
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Types p = Types.fromJson(event.snapshot.value);
      typesList.add(p);
      keyslist.add(event.snapshot.key.toString());
      print(keyslist);
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
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, AddTypes.routeName);
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Text(
                      'أنواع الرخام',
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
                          itemCount: keyslist.length,
                          itemBuilder: (context, index) {
                            return Container(
                              child: InkWell(
                                onTap: () {},
                                child: Card(
                                  color: HexColor('#ccefc0'),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        right: 10.w, left: 10.w),
                                    child: Center(
                                      child: Column(children: [
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        FittedBox(
                                          fit: BoxFit.fitWidth,
                                          child: Text(
                                            '${keyslist[index]}',
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
                                        
                                        InkWell(
                                          onTap: () async {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        super.widget));
                                            FirebaseDatabase.instance
                                                .reference()
                                                .child('types')
                                                .child(
                                                    '${typesList[index].id}')
                                                .remove();
                                          },
                                          child: Icon(Icons.delete,
                                              color: Color.fromARGB(
                                                  255, 122, 122, 122)),
                                        )
                                      ]),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          staggeredTileBuilder: (int index) =>
                              new StaggeredTile.count(3, index.isEven ? 2 : 2),
                          mainAxisSpacing: 10.0,
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
