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
  int? number;

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
      this.productName,
      this.number});

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
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['product_id'] = productId;
    data['status'] = status;
    data['quantity'] = quantity;
    data['price'] = price;
    data['total_price'] = totalPrice;
    data['booking_date'] = bookingDate;
    data['delivery date'] = deliveryDate;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['image'] = image;
    data['product_name'] = productName;
    data['number'] = number;
    return data;
  }
}
