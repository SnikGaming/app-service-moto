class Product {
  List<Data>? data;
  int? totalPages;
  int? currentPage;

  Product({this.data, this.totalPages, this.currentPage});

  Product.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    currentPage = json['current_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = this.totalPages;
    data['current_page'] = this.currentPage;
    return data;
  }
}

class Data {
  String? name;
  String? image;
  String? description;
  int? number;
  int? price;
  int? like;
  int? status;

  Data(
      {this.name,
      this.image,
      this.description,
      this.number,
      this.price,
      this.like,
      this.status});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    description = json['description'];
    number = json['number'];
    price = json['price'];
    like = json['like'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    data['description'] = this.description;
    data['number'] = this.number;
    data['price'] = this.price;
    data['like'] = this.like;
    data['status'] = this.status;
    return data;
  }
}