class Booking {
  int? status;
  List<Data>? data;
  int? currentPage;
  int? lastPage;
  int? perPage;
  int? totalItems;

  Booking(
      {this.status,
      this.data,
      this.currentPage,
      this.lastPage,
      this.perPage,
      this.totalItems});

  Booking.fromJson(Map<String, dynamic> json) {
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
  int? customerId;
  int? mechanicId;
  String? color;
  String? service;
  String? note;
  String? bookingTime;
  int? status;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.customerId,
      this.mechanicId,
      this.color,
      this.service,
      this.note,
      this.bookingTime,
      this.status,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    mechanicId = json['mechanic_id'];
    color = json['color'];
    service = json['service'];
    note = json['note'];
    bookingTime = json['booking_time'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['mechanic_id'] = this.mechanicId;
    data['color'] = this.color;
    data['service'] = this.service;
    data['note'] = this.note;
    data['booking_time'] = this.bookingTime;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
