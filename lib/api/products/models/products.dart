class Product {
  List<Data>? data;
  int? totalPages;
  int? currentPage;

  Product({this.data, this.totalPages, this.currentPage});

  Product.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    currentPage = json['current_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = totalPages;
    data['current_page'] = currentPage;
    return data;
  }
}

class Data {
  String? id;
  int? categoryId;
  String? name;
  String? image;
  String? description;
  int? number;
  int? price;
  int? like;
  int? status;
  int? love;

  Data(
      {this.id,
      this.categoryId,
      this.name,
      this.image,
      this.description,
      this.number,
      this.price,
      this.like,
      this.love,
      this.status});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
    number = json['number'];
    price = json['price'];
    like = json['like'];
    status = json['status'];
    love = json['love'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category_id'] = categoryId;
    data['name'] = name;
    data['image'] = image;
    data['description'] = description;
    data['number'] = number;
    data['price'] = price;
    data['like'] = like;
    data['status'] = status;
    data['love'] = love;

    return data;
  }
}
