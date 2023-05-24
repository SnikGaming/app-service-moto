import 'package:dio/dio.dart';

import '../../home/api/APIBASE.dart';
import '../../home/api/products/models/products.dart' as products;

Future<products.Data?> getProductDetail({required int id}) async {
  // print('this is user ');
  Response response;
  try {
    response = await ApiBase.get(path: '/api/products/$id');
  } catch (e) {
    return null;
  }
  final jsonData = response.data['data'];
  // print('data test ${jsonData}');
  // saveUserData(jsonData);
  return products.Data.fromJson(jsonData);
}
