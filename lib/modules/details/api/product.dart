import 'package:dio/dio.dart';

import '../../../api/APIBASE.dart';
import '../../../api/products/models/products.dart' as products;

Future<products.Data> getProductDetail({required int id}) async {
  // print('this is user ');
  Response response;

  response = await ApiBase.get(path: '/api/products/$id');

  final jsonData = response.data['data'];
  // print('data test ${jsonData}');
  // saveUserData(jsonData);
  return products.Data.fromJson(jsonData);
}
