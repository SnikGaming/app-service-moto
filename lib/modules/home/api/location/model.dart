class Location {
  List<Data>? data;

  Location({this.data});

  Location.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? provinceId;
  String? name;
  List<Districts>? districts;

  Data({this.provinceId, this.name, this.districts});

  Data.fromJson(Map<String, dynamic> json) {
    provinceId = json['province_id'];
    name = json['name'];
    if (json['districts'] != null) {
      districts = <Districts>[];
      json['districts'].forEach((v) {
        districts!.add(new Districts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['province_id'] = this.provinceId;
    data['name'] = this.name;
    if (this.districts != null) {
      data['districts'] = this.districts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Districts {
  int? districtId;
  int? provinceId;
  String? name;
  List<Wards>? wards;

  Districts({this.districtId, this.provinceId, this.name, this.wards});

  Districts.fromJson(Map<String, dynamic> json) {
    districtId = json['district_id'];
    provinceId = json['province_id'];
    name = json['name'];
    if (json['wards'] != null) {
      wards = <Wards>[];
      json['wards'].forEach((v) {
        wards!.add(new Wards.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['district_id'] = this.districtId;
    data['province_id'] = this.provinceId;
    data['name'] = this.name;
    if (this.wards != null) {
      data['wards'] = this.wards!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Wards {
  int? wardsId;
  int? districtId;
  String? name;

  Wards({this.wardsId, this.districtId, this.name});

  Wards.fromJson(Map<String, dynamic> json) {
    wardsId = json['wards_id'];
    districtId = json['district_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wards_id'] = this.wardsId;
    data['district_id'] = this.districtId;
    data['name'] = this.name;
    return data;
  }
}
