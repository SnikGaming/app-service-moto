class ProductModel {
  int? id;
  String? productName;
  int? price;
  String? description;

  ProductModel({this.id, this.productName, this.price, this.description});

  ProductModel.fromJson(Map<String, dynamic> res)
      : id = res['id'],
        productName = res['product_name'],
        price = res['price'],
        description = res['description'];

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'product_name': productName,
      'price': price,
      'description': description
    };
  }
}
