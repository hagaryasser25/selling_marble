import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserDetails extends StatefulWidget {
  String name;
  String imageUrl;
  String benefits;
  String damage;
  UserDetails({
    required this.name,
    required this.imageUrl,
    required this.benefits,
    required this.damage,
  });

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding:EdgeInsets.only(
                right: 10.w,
                left: 10.w
              ),
              child: Column(
                children: [
                  Stack(
                    children: <Widget>[
                      Container(
                        decoration: new BoxDecoration(color: Colors.white),
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: 450.h,
                        child: Image.asset(
                          widget.imageUrl,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Positioned(
                        top: 30.h,
                        left:
                            15.w, //give the values according to your requirement
                        child: SizedBox.fromSize(
                          size: Size(30, 30),
                          child: ClipOval(
                            child: Material(
                              color: Colors.white,
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(Icons.arrow_forward_ios_outlined,
                                        size: 15.0), // <-- Icon
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text('${widget.name}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      )),
                  SizedBox(
                    height: 10.h,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Text('الفوائد : ${widget.benefits}',
                        style: TextStyle(
                          fontSize: 16,
                        )),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Text('الأضرار : ${widget.damage}',style: TextStyle(
                          fontSize: 16,
                        ) ),
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