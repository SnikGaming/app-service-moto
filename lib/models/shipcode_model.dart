class ShipCode {
  String name;
  String price;
  String description;
  ShipCode(
      {required this.name, required this.price, required this.description});
  static List<ShipCode> lsShipCode = [
    ShipCode(
        name: 'Thường',
        price: '30000',
        description: 'Sản phẩm sẽ được giao trong 7 - 10 ngày.'),
    ShipCode(
        name: 'Nhanh',
        price: '45000',
        description: 'Sản phẩm sẽ giao trong 3- 5 ngày.'),
    // ShipCode(
    //     name: 'Hỏa tốc',
    //     price: '60000',
    //     description: 'Sản phẩm sẽ được giao trong 24h tiếp theo.'),
  ];
}
