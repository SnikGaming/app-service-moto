class Order {
  int? status;
  List<Data>? data;
  int? currentPage;
  int? lastPage;
  int? perPage;
  int? totalItems;

  Order(
      {this.status,
      this.data,
      this.currentPage,
      this.lastPage,
      this.perPage,
      this.totalItems});

  Order.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    currentPage = json['current_page'];
    lastPage = json['last_page'];
    perPage = json['per_page'];
    totalItems = json['total_items'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['current_page'] = currentPage;
    data['last_page'] = lastPage;
    data['per_page'] = perPage;
    data['total_items'] = totalItems;
    return data;
  }
}

class Data {
  int? id;
  int? userId;
  int? status;
  int? totalPrice;
  String? address;
  String? name;
  int? payment;

  String? note;
  int? ship;
  String? bookingDate;
  String? deliveryDate;
  String? createdAt;
  String? updatedAt;
  List<Product>? product;

  Data(
      {this.id,
      this.userId,
      this.status,
      this.totalPrice,
      this.address,
      this.name,
      this.note,
      this.ship,
      this.payment,
      this.bookingDate,
      this.deliveryDate,
      this.createdAt,
      this.updatedAt,
      this.product});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    status = json['status'];
    totalPrice = json['total_price'];
    payment = json['payment'];

    address = json['address'];
    name = json['name'];
    note = json['note'];
    ship = json['ship'];
    bookingDate = json['booking_date'];
    deliveryDate = json['delivery date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['product'] != null) {
      product = <Product>[];
      json['product'].forEach((v) {
        product!.add(Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['status'] = status;
    data['total_price'] = totalPrice;
    data['address'] = address;
    data['name'] = name;
    data['note'] = note;
    data['ship'] = ship;
    data['payment'] = this.payment;
    data['booking_date'] = bookingDate;
    data['delivery date'] = deliveryDate;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (product != null) {
      data['product'] = product!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  int? id;

  Product({this.id});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    return data;
  }
}
