import 'package:flutter/cupertino.dart';

class Marble {
  Marble({
    String? name,
    String? company,
    int? amount,
    String? id,
    String? imageUrl,
    String? imageUrl2,
    String? description,
  }) {
    _name = name;
    _price = price;
    _company = company;
    _amount = amount;
    _id = id;
    _imageUrl = imageUrl;
    _imageUrl2 = imageUrl2;
    _description = description;
  }

  Marble.fromJson(dynamic json) {
    _name = json['name'];
    _price = json['price'];
    _company = json['companyName'];
    _amount = json['amount'];
    _id = json['id'];
    _imageUrl = json['imageUrl'];
    _imageUrl2 = json['imageUrl2'];
    _description = json['description'];
  }

  String? _name;
  int? _price;
  String? _company;
  int? _amount;
  String? _id;
  String? _imageUrl;
  String? _imageUrl2;
  String? _description;

  String? get name => _name;
  int? get price => _price;
  String? get company => _company;
  int? get amount => _amount;
  String? get id => _id;
  String? get imageUrl => _imageUrl;
  String? get imageUrl2 => _imageUrl2;
  String? get description => _description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['companyName'] = _company;
    map['amount'] = _amount;
    map['id'] = _id;
    map['imageUrl'] = _imageUrl;
    map['imageUrl2'] = _imageUrl2;
    map['description'] = _description;

    return map;
  }
}
