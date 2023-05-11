import 'dart:io';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:selling_marble/pages/admin/admin_bottom.dart';
import 'package:selling_marble/pages/company/company_home.dart';

import '../models/types_model.dart';

class AddMarble extends StatefulWidget {
  String companyName;
  static const routeName = '/addBuilding';
  AddMarble({required this.companyName});

  @override
  State<AddMarble> createState() => _AddMarbleState();
}

class _AddMarbleState extends State<AddMarble> {
  String imageUrl = '';
  File? image;
  String imageUrl2 = '';
  File? image2;
  var nameController = TextEditingController();
  var priceController = TextEditingController();
  var amountController = TextEditingController();
  var descriptionController = TextEditingController();
  String dropdownValue = 'محلي';
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
  Future pickImageFromDevice() async {
    final xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (xFile == null) return;
    final tempImage = File(xFile.path);
    setState(() {
      image = tempImage;
      print(image!.path);
    });

    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images');
    Reference refrenceImageToUpload = referenceDirImages.child(uniqueFileName);
    try {
      await refrenceImageToUpload.putFile(File(xFile.path));

      imageUrl = await refrenceImageToUpload.getDownloadURL();
    } catch (error) {}
    print(imageUrl);
  }

  @override
  Future pickImageFromDevice2() async {
    final xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (xFile == null) return;
    final tempImage = File(xFile.path);
    setState(() {
      image2 = tempImage;
      print(image2!.path);
    });

    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images');
    Reference refrenceImageToUpload = referenceDirImages.child(uniqueFileName);
    try {
      await refrenceImageToUpload.putFile(File(xFile.path));

      imageUrl2 = await refrenceImageToUpload.getDownloadURL();
    } catch (error) {}
    print(imageUrl2);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
          body: Padding(
            padding: EdgeInsets.only(
              top: 40.h,
            ),
            child: Padding(
              padding: EdgeInsets.only(right: 10.w, left: 10.w),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 50.w,
                      ),
                      Text('صورة الرخام'),
                      SizedBox(
                        width: 130.w,
                      ),
                      Text('صورة المنتج')
                    ],
                  ),
                  Row(
                    children: [
                      Align(
                        child: Stack(
                          children: [
                            Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 20),
                                child: CircleAvatar(
                                  radius: 65,
                                  backgroundColor: HexColor('#d9ead3'),
                                  backgroundImage:
                                      image == null ? null : FileImage(image!),
                                )),
                            Positioned(
                                top: 120,
                                left: 120,
                                child: SizedBox(
                                  width: 50,
                                  child: RawMaterialButton(
                                      // constraints: BoxConstraints.tight(const Size(45, 45)),
                                      elevation: 10,
                                      fillColor:
                                          Color.fromARGB(255, 71, 233, 133),
                                      child: const Align(
                                          // ignore: unnecessary_const
                                          child: Icon(Icons.add_a_photo,
                                              color: Colors.white, size: 22)),
                                      padding: const EdgeInsets.all(15),
                                      shape: const CircleBorder(),
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text('Choose option',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Color.fromARGB(
                                                            255,
                                                            71,
                                                            233,
                                                            133))),
                                                content: SingleChildScrollView(
                                                  child: ListBody(
                                                    children: [
                                                      InkWell(
                                                          onTap: () {
                                                            pickImageFromDevice();
                                                          },
                                                          splashColor: HexColor(
                                                              '#FA8072'),
                                                          child: Row(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Icon(
                                                                    Icons.image,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            71,
                                                                            233,
                                                                            133)),
                                                              ),
                                                              Text('Gallery',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ))
                                                            ],
                                                          )),
                                                      InkWell(
                                                          onTap: () {
                                                            // pickImageFromCamera();
                                                          },
                                                          splashColor: HexColor(
                                                              '#FA8072'),
                                                          child: Row(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Icon(
                                                                    Icons
                                                                        .camera,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            71,
                                                                            233,
                                                                            133)),
                                                              ),
                                                              Text('Camera',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ))
                                                            ],
                                                          )),
                                                      InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              Navigator.pop(
                                                                  context);
                                                            });
                                                          },
                                                          splashColor: HexColor(
                                                              '#FA8072'),
                                                          child: Row(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Icon(
                                                                    Icons
                                                                        .remove_circle,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            71,
                                                                            233,
                                                                            133)),
                                                              ),
                                                              Text('Remove',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ))
                                                            ],
                                                          ))
                                                    ],
                                                  ),
                                                ),
                                              );
                                            });
                                      }),
                                )),
                          ],
                        ),
                      ),
                      Align(
                        child: Stack(
                          children: [
                            Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 20),
                                child: CircleAvatar(
                                  radius: 65,
                                  backgroundColor: HexColor('#d9ead3'),
                                  backgroundImage: image2 == null
                                      ? null
                                      : FileImage(image2!),
                                )),
                            Positioned(
                                top: 120,
                                left: 120,
                                child: SizedBox(
                                  width: 50,
                                  child: RawMaterialButton(
                                      // constraints: BoxConstraints.tight(const Size(45, 45)),
                                      elevation: 10,
                                      fillColor:
                                          Color.fromARGB(255, 71, 233, 133),
                                      child: const Align(
                                          // ignore: unnecessary_const
                                          child: Icon(Icons.add_a_photo,
                                              color: Colors.white, size: 22)),
                                      padding: const EdgeInsets.all(15),
                                      shape: const CircleBorder(),
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text('Choose option',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Color.fromARGB(
                                                            255,
                                                            71,
                                                            233,
                                                            133))),
                                                content: SingleChildScrollView(
                                                  child: ListBody(
                                                    children: [
                                                      InkWell(
                                                          onTap: () {
                                                            pickImageFromDevice2();
                                                          },
                                                          splashColor: HexColor(
                                                              '#FA8072'),
                                                          child: Row(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Icon(
                                                                    Icons.image,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            71,
                                                                            233,
                                                                            133)),
                                                              ),
                                                              Text('Gallery',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ))
                                                            ],
                                                          )),
                                                      InkWell(
                                                          onTap: () {
                                                            // pickImageFromCamera();
                                                          },
                                                          splashColor: HexColor(
                                                              '#FA8072'),
                                                          child: Row(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Icon(
                                                                    Icons
                                                                        .camera,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            71,
                                                                            233,
                                                                            133)),
                                                              ),
                                                              Text('Camera',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ))
                                                            ],
                                                          )),
                                                      InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              Navigator.pop(
                                                                  context);
                                                            });
                                                          },
                                                          splashColor: HexColor(
                                                              '#FA8072'),
                                                          child: Row(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Icon(
                                                                    Icons
                                                                        .remove_circle,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            71,
                                                                            233,
                                                                            133)),
                                                              ),
                                                              Text('Remove',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ))
                                                            ],
                                                          ))
                                                    ],
                                                  ),
                                                ),
                                              );
                                            });
                                      }),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  DecoratedBox(
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            width: 1.0,
                            style: BorderStyle.solid,
                            color: Color.fromARGB(255, 71, 233, 133)),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      underline: SizedBox(),

                      // Step 3.
                      value: dropdownValue,
                      icon: Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: Icon(Icons.arrow_drop_down,
                            color: Color.fromARGB(255, 71, 233, 133)),
                      ),

                      // Step 4.
                      items: keyslist
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Center(
                            child: Text(
                              value,
                              style: TextStyle(
                                  fontSize: 21,
                                  color: Color.fromARGB(255, 71, 233, 133)),
                            ),
                          ),
                        );
                      }).toList(),
                      // Step 5.
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                    height: 65.h,
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        fillColor: HexColor('#155564'),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 71, 233, 133),
                              width: 2.0),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'اسم الرخام',
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  SizedBox(
                    height: 65.h,
                    child: TextField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                        fillColor: HexColor('#155564'),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 71, 233, 133),
                              width: 2.0),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'تفاصيل المنتج المصنوع',
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  SizedBox(
                    height: 65.h,
                    child: TextField(
                      controller: priceController,
                      decoration: InputDecoration(
                        fillColor: HexColor('#155564'),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 71, 233, 133),
                              width: 2.0),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'سعر المتر',
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  SizedBox(
                    height: 65.h,
                    child: TextField(
                      controller: amountController,
                      decoration: InputDecoration(
                        fillColor: HexColor('#155564'),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 71, 233, 133),
                              width: 2.0),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'الكمية المتاحة',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints.tightFor(
                        width: double.infinity, height: 65.h),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 71, 233, 133),
                      ),
                      onPressed: () async {
                        String name = nameController.text.trim();
                        String description = descriptionController.text.trim();
                        int price = int.parse(priceController.text);
                        int amount = int.parse(amountController.text);

                        if (name.isEmpty ||
                            price == null ||
                            amount == null ||
                            imageUrl.isEmpty ||
                            description.isEmpty ||
                            imageUrl2.isEmpty) {
                          CherryToast.info(
                            title: Text('Please Fill all Fields'),
                            actionHandler: () {},
                          ).show(context);
                          return;
                        }

                        User? user = FirebaseAuth.instance.currentUser;

                        if (user != null) {
                          String uid = user.uid;
                          int date = DateTime.now().millisecondsSinceEpoch;

                          DatabaseReference companyRef = FirebaseDatabase
                              .instance
                              .reference()
                              .child('Marble')
                              .child('${widget.companyName}')
                              .child('$dropdownValue');

                          String? id = companyRef.push().key;

                          await companyRef.child(id!).set({
                            'imageUrl': imageUrl,
                            'id': id,
                            'name': name,
                            'price': price,
                            'companyName': widget.companyName,
                            'amount': amount,
                            'type': dropdownValue,
                            'imageUrl2': imageUrl2,
                            'description': description,
                          });
                        }
                        showAlertDialog(context);
                      },
                      child: Text('حفظ'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void showAlertDialog(BuildContext context) {
  Widget remindButton = TextButton(
    style: TextButton.styleFrom(
      primary: HexColor('#6bbcba'),
    ),
    child: Text("Ok"),
    onPressed: () {
      Navigator.pushNamed(context, CompanyHome.routeName);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Notice"),
    content: Text("تم أضافة المنتج"),
    actions: [
      remindButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
