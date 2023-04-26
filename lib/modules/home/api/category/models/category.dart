class Category {
  int? status;
  String? message;
  List<Data>? data;

  Category({this.status, this.message, this.data});

  Category.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? uid;
  String? ten;
  String? trangThai;
  String? ngayTao;
  String? ngaySua;

  Data({this.uid, this.ten, this.trangThai, this.ngayTao, this.ngaySua});

  Data.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    ten = json['ten'];
    trangThai = json['trang_thai'];
    ngayTao = json['ngay_tao'];
    ngaySua = json['ngay_sua'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['ten'] = this.ten;
    data['trang_thai'] = this.trangThai;
    data['ngay_tao'] = this.ngayTao;
    data['ngay_sua'] = this.ngaySua;
    return data;
  }
}
