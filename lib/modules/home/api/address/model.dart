class Address {
  List<Data>? data;

  Address({this.data});

  Address.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? phoneNumber;
  String? address;
  int? idProvince;
  String? province;
  int? idDistrict;
  String? district;
  int? idWard;
  String? ward;

  Data(
      {this.id,
      this.name,
      this.phoneNumber,
      this.address,
      this.idProvince,
      this.province,
      this.idDistrict,
      this.district,
      this.idWard,
      this.ward});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    address = json['address'];
    idProvince = json['idProvince'];
    province = json['province'];
    idDistrict = json['idDistrict'];
    district = json['district'];
    idWard = json['idWard'];
    ward = json['ward'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone_number'] = phoneNumber;
    data['address'] = address;
    data['idProvince'] = idProvince;
    data['province'] = province;
    data['idDistrict'] = idDistrict;
    data['district'] = district;
    data['idWard'] = idWard;
    data['ward'] = ward;
    return data;
  }
}
