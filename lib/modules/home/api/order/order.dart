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
        data!.add(new Data.fromJson(v));
      });
    }
    currentPage = json['current_page'];
    lastPage = json['last_page'];
    perPage = json['per_page'];
    totalItems = json['total_items'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['current_page'] = this.currentPage;
    data['last_page'] = this.lastPage;
    data['per_page'] = this.perPage;
    data['total_items'] = this.totalItems;
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
  Null? note;
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
        product!.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['status'] = this.status;
    data['total_price'] = this.totalPrice;
    data['address'] = this.address;
    data['name'] = this.name;
    data['note'] = this.note;
    data['ship'] = this.ship;
    data['booking_date'] = this.bookingDate;
    data['delivery date'] = this.deliveryDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.product != null) {
      data['product'] = this.product!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}
