class products {
  int? status;
  String? message;
  List<Data>? data;

  products({this.status, this.message, this.data});

  products.fromJson(Map<String, dynamic> json) {
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
  String? loaiSanPhamId;
  String? ten;
  String? hinhAnh;
  String? moTa;
  int? gia;
  int? soLuong;
  String? trangThai;
  String? ngayTao;
  String? ngaySua;
  int? yeuThich;
  String? tenLoaiSanPham;

  Data(
      {this.uid,
      this.loaiSanPhamId,
      this.ten,
      this.hinhAnh,
      this.moTa,
      this.gia,
      this.soLuong,
      this.trangThai,
      this.ngayTao,
      this.ngaySua,
      this.yeuThich,
      this.tenLoaiSanPham});

  Data.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    loaiSanPhamId = json['loai_san_pham_id'];
    ten = json['ten'];
    hinhAnh = json['hinh_anh'];
    moTa = json['mo_ta'];
    gia = json['gia'];
    soLuong = json['so_luong'];
    trangThai = json['trang_thai'];
    ngayTao = json['ngay_tao'];
    ngaySua = json['ngay_sua'];
    yeuThich = json['yeu_thich'];
    tenLoaiSanPham = json['ten_loai_san_pham'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['loai_san_pham_id'] = this.loaiSanPhamId;
    data['ten'] = this.ten;
    data['hinh_anh'] = this.hinhAnh;
    data['mo_ta'] = this.moTa;
    data['gia'] = this.gia;
    data['so_luong'] = this.soLuong;
    data['trang_thai'] = this.trangThai;
    data['ngay_tao'] = this.ngayTao;
    data['ngay_sua'] = this.ngaySua;
    data['yeu_thich'] = this.yeuThich;
    data['ten_loai_san_pham'] = this.tenLoaiSanPham;
    return data;
  }
}
