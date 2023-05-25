// ignore_for_file: library_private_types_in_public_api

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
            const SizedBox(height: 16),
            Text(
              widget.product.name!,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '\$${widget.product.price}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Description:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              widget.product.description!,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'Quantity:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                IconButton(
                  onPressed:
                      _quantity > 1 ? () => setState(() => _quantity--) : null,
                  icon: const Icon(Icons.remove),
                ),
                const SizedBox(width: 16),
                Text('$_quantity'),
                const SizedBox(width: 16),
                IconButton(
                  onPressed: () => setState(() => _quantity++),
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // TODO: Add the product to the shopping cart and navigate to the shopping cart screen.
              },
              child: const Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}
