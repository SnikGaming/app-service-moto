// ignore_for_file: camel_case_types

class review {
  List<Data>? data;
  int? totalStars;
  int? totalPages;
  int? currentPage;

  review({this.data, this.totalStars, this.totalPages, this.currentPage});

  review.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    totalStars = json['total_stars'];
    totalPages = json['total_pages'];
    currentPage = json['current_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['total_stars'] = totalStars;
    data['total_pages'] = totalPages;
    data['current_page'] = currentPage;
    return data;
  }
}

class Data {
  int? id;
  int? userId;
  String? productId;
  String? time;
  String? comment;
  int? rating;
  String? createdAt;
  String? updatedAt;
  String? name;
  String? image;
  User? user;

  Data(
      {this.id,
      this.userId,
      this.productId,
      this.time,
      this.comment,
      this.rating,
      this.createdAt,
      this.updatedAt,
      this.name,
      this.image,
      this.user});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    productId = json['product_id'];
    time = json['time'];
    comment = json['comment'];
    rating = json['rating'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    image = json['image'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['product_id'] = productId;
    data['time'] = time;
    data['comment'] = comment;
    data['rating'] = rating;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['name'] = name;
    data['image'] = image;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? image;
  String? imageUrl;

  User({this.id, this.name, this.image, this.imageUrl});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['image_url'] = imageUrl;
    return data;
  }
}
