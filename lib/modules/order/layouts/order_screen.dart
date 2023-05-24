import 'package:flutter/material.dart';

import '../../../components/districts/location.dart';
import '../../../functions/hideExcessCharacters.dart';

class OrderScreen extends StatefulWidget {
  String json;
  OrderScreen({Key? key, required this.json}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  String selectedAddress = ''; // Địa chỉ giao hàng được chọn
  String selectedPaymentMethod = ''; // Phương thức thanh toán được chọn
  double shippingFee = 20000; // Phí ship
  String discountCode = ''; // Mã giảm giá
  double totalPrice = 500000; // Tổng số tiền cần thanh toán

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Thanh toán'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Chọn địa chỉ giao hàng
            // TextFormField(
            //   onChanged: (value) {
            //     setState(() {
            //       selectedAddress = value;
            //     });
            //   },
            //   decoration: const InputDecoration(
            //     labelText: 'Địa chỉ giao hàng',
            //   ),
            // ),
            Container(
              height: 60,
              // color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Số điện thoại 0383892964'),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          '${hideExcessCharacters('Ấp Mỹ Nam 2, Xã Mỹ Quý,Huyện Tháp Mười, Đồng Tháp')}'),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      print('data test');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => LocationSelectionScreen()));
                    },
                    icon: Icon(Icons.edit),
                  )
                  // Row(
                  //   children: [Icon(Icons.edit), Text('Chỉnh sửa')],
                  // )
                ],
              ),
            ),
            // Hiển thị danh sách sản phẩm trong giỏ hàng
            Expanded(
              child: ListView.builder(
                itemCount: 5, // Số lượng sản phẩm trong giỏ hàng
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Sản phẩm $index'),
                    subtitle: Text('Giá: 100,000 đ'),
                    trailing: Text('Số lượng: 1'),
                  );
                },
              ),
            ),
            // SizedBox(
            //   height: 140,
            //   child: ListView.builder(
            //     scrollDirection: Axis.horizontal,

            //     itemBuilder: (context, i) => Container(
            //       // height: 140,
            //       decoration:const BoxDecoration(
            //         color: Colors.red,
            //       ),
            //     ),
            //   ),
            // ),
            // Phí ship
            ListTile(
              title: Text('Phí ship'),
              trailing: Text('$shippingFee đ'),
            ),

            // Nhập mã giảm giá
            TextFormField(
              onChanged: (value) {
                setState(() {
                  discountCode = value;
                  // TODO: Áp dụng mã giảm giá và cập nhật totalPrice
                });
              },
              decoration: InputDecoration(
                labelText: 'Nhập mã giảm giá (nếu có)',
              ),
            ),

            // Tổng số tiền và nút thanh toán
            Container(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Tổng cộng: ${totalPrice - shippingFee} đ', // Tổng số tiền cần thanh toán sau khi trừ phí ship
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      // Xử lý sự kiện khi người dùng bấm nút thanh toán
                    },
                    child: Text('Thanh toán'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
