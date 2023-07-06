class Booking {
  int? status;
  List<Data>? data;
  int? totalItems;

  Booking({this.status, this.data, this.totalItems});

  Booking.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    totalItems = json['total_items'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['total_items'] = totalItems;
    return data;
  }
}

class Data {
  int? id;
  int? customerId;
  int? mechanicId;
  String? color;
  String? address;
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
      this.address,
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
    address = json['address'];
    service = json['service'];
    note = json['note'];
    bookingTime = json['booking_time'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['customer_id'] = customerId;
    data['mechanic_id'] = mechanicId;
    data['color'] = color;
    data['address'] = address;
    data['service'] = service;
    data['note'] = note;
    data['booking_time'] = bookingTime;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
