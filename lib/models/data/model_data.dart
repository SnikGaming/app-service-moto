import 'dart:convert';
import 'dart:io';

class ProductData {
  String? src;
  String? title;
  String? price;

  ProductData({this.src, this.title, this.price});

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      src: json['src'],
      title: json['title'],
      price: json['price'],
    );
  }
}
