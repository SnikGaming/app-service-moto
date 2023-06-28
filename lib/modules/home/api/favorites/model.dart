class Favorite {
  List<Data>? data;
  int? totalPages;
  int? currentPage;

  Favorite({this.data, this.totalPages, this.currentPage});

  Favorite.fromJson(Map<String, dynamic> json) {
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
  int? id;
  int? userId;
  int? productId;
  String? name;
  int? price;
  String? image;
  int? like;

  Data(
      {this.id,
      this.userId,
      this.productId,
      this.name,
      this.price,
      this.image,
      this.like});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    productId = json['product_id'];
    name = json['name'];
    price = json['price'];
    image = json['image'];
    like = json['like'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['product_id'] = this.productId;
    data['name'] = this.name;
    data['price'] = this.price;
    data['image'] = this.image;
    data['like'] = this.like;
    return data;
  }
}
