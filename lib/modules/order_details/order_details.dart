import 'package:flutter/material.dart';

import '../home/api/products/api_product.dart';
import '../home/api/products/models/products.dart';

class OrderDetails extends StatefulWidget {
  // List<Product> value;
  List<int> value;
  OrderDetails({super.key, required this.value});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  List<Data> sent = [];
  loadData() async {
    await APIProduct.getDataById(data: widget.value);
    sent = APIProduct.dataOrder;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.green,
        child: ListView.builder(
            itemCount: sent.length,
            itemBuilder: ((context, i) {
              final data = sent[i];
              return Center(
                child: Text(data.name.toString()),
              );
            })),
      ),
    );
  }
}
