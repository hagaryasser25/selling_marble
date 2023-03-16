import 'package:flutter/cupertino.dart';

class Cart {
  Cart({
    String? name,
    int? price,
    String? imageUrl,
    int? amount,
    int? total,
    String? id,
    String? companyName,
    String? userName,
    String? userPhone,
  }) {
    _name = name;
    _price = price;
    _imageUrl = imageUrl;
    _amount = amount;
    _total = total;
    _id = id;
    _companyName = companyName;
    _userName = userName;
    _userPhone = userPhone;
  }

  Cart.fromJson(dynamic json) {
    _name = json['name'];
    _price = json['price'];
    _imageUrl = json['imageUrl'];
    _amount = json['amount'];
    _total = json['total'];
    _id = json['id'];
    _companyName = json['companyName'];
    _userName = json['userName'];
    _userPhone = json['userPhone'];
  }

  String? _name;
  int? _price;
  String? _imageUrl;
  int? _amount;
  int? _total;
  String? _id;
  String? _companyName;
  String? _userName;
  String? _userPhone;

  String? get name => _name;
  int? get price => _price;
  String? get imageUrl => _imageUrl;
  int? get amount => _amount;
  int? get total => _total;
  String? get id => _id;
  String? get companyName => _companyName;
  String? get userName => _userName;
  String? get userPhone => _userPhone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['price'] = _price;
    map['imageUrl'] = _imageUrl;
    map['amount'] = _amount;
    map['total'] = _total;
    map['id'] = _id;
    map['companyName'] = _companyName;
    map['userName'] = _userName;
    map['userPhone'] = _userPhone;

    return map;
  }
}
