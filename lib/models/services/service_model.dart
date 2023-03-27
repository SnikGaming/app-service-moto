class ServiceModel {
  final int id;
  final String name;
  final String shortDescription;
  final String detailDescription;
  final String benefit;
  final String price;

  ServiceModel({
    required this.id,
    required this.name,
    required this.shortDescription,
    required this.detailDescription,
    required this.benefit,
    required this.price,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'],
      name: json['name'],
      shortDescription: json['short_description'],
      detailDescription: json['detail_description'],
      benefit: json['benefit'],
      price: json['price'],
    );
  }
  Map<String, Object?> toJson() {
    return {
      'id': id,
      'name': name,
      'short_description': shortDescription,
      'detail_description': detailDescription,
      'benefit': benefit,
      'price': price
    };
  }
}
