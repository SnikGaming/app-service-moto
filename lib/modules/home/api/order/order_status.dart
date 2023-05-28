class OrderStatus {
  int? status;
  Data? data;

  OrderStatus({this.status, this.data});

  OrderStatus.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? status0;
  String? status1;
  String? status2;
  String? status3;

  Data({this.status0, this.status1, this.status2, this.status3});

  Data.fromJson(Map<String, dynamic> json) {
    status0 = json['status_0'];
    status1 = json['status_1'];
    status2 = json['status_2'];
    status3 = json['status_3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_0'] = this.status0;
    data['status_1'] = this.status1;
    data['status_2'] = this.status2;
    data['status_3'] = this.status3;
    return data;
  }
}
