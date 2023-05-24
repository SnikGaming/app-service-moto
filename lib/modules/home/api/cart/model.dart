class CartModel {
  int? status;
  List<Data>? data;
  int? currentPage;
  int? lastPage;
  int? perPage;
  int? totalItems;

  CartModel(
      {this.status,
      this.data,
      this.currentPage,
      this.lastPage,
      this.perPage,
      this.totalItems});

  CartModel.fromJson(Map<String, dynamic> json) {
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
  int? productId;
  int? status;
  int? quantity;
  String? price;
  int? totalPrice;
  String? bookingDate;
  String? deliveryDate;
  String? createdAt;
  String? updatedAt;
  String? image;
  String? productName;

  Data(
      {this.id,
      this.userId,
      this.productId,
      this.status,
      this.quantity,
      this.price,
      this.totalPrice,
      this.bookingDate,
      this.deliveryDate,
      this.createdAt,
      this.updatedAt,
      this.image,
      this.productName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    productId = json['product_id'];
    status = json['status'];
    quantity = json['quantity'];
    price = json['price'];
    totalPrice = json['total_price'];
    bookingDate = json['booking_date'];
    deliveryDate = json['delivery date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image'];
    productName = json['product_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['product_id'] = this.productId;
    data['status'] = this.status;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['total_price'] = this.totalPrice;
    data['booking_date'] = this.bookingDate;
    data['delivery date'] = this.deliveryDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['image'] = this.image;
    data['product_name'] = this.productName;
    return data;
  }
}
