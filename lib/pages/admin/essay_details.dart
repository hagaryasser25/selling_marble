import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EssayDetails extends StatefulWidget {
  String title;
  String content;
  EssayDetails({
    required this.title,
    required this.content,
  });

  @override
  State<EssayDetails> createState() => _EssayDetailsState();
}

class _EssayDetailsState extends State<EssayDetails> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset('assets/images/mu.png'),
                SizedBox(
                  height: 10.h,
                ),
                Text('${widget.title}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    )),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding:  EdgeInsets.only(
                    right: 10.w,
                    left: 10.w,
                  ),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text('${widget.content}',
                        style: TextStyle(
                          fontSize: 16,
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
