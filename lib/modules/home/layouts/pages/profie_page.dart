import 'package:flutter/material.dart';

import '../../api/products/models/products.dart';

class ProFilePage extends StatefulWidget {
  const ProFilePage({super.key});

  @override
  State<ProFilePage> createState() => _ProFilePageState();
}

class _ProFilePageState extends State<ProFilePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
      ),
    );
  }
}

class ProductPurchaseScreen extends StatefulWidget {
  final Data product;

  const ProductPurchaseScreen({Key? key, required this.product})
      : super(key: key);

  @override
  _ProductPurchaseScreenState createState() => _ProductPurchaseScreenState();
}

class _ProductPurchaseScreenState extends State<ProductPurchaseScreen> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Purchase ${widget.product.name}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Text(
              widget.product.name!,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '\$${widget.product.price}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Description:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              widget.product.description!,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Quantity:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                IconButton(
                  onPressed:
                      _quantity > 1 ? () => setState(() => _quantity--) : null,
                  icon: Icon(Icons.remove),
                ),
                SizedBox(width: 16),
                Text('$_quantity'),
                SizedBox(width: 16),
                IconButton(
                  onPressed: () => setState(() => _quantity++),
                  icon: Icon(Icons.add),
                ),
              ],
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // TODO: Add the product to the shopping cart and navigate to the shopping cart screen.
              },
              child: Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}
