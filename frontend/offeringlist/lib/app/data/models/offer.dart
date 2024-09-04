class Offer {
  String? id;
  String? title;
  String? description;
  double? discountPercentage;
  double? originalPrice;
  double? discountedPrice;

  Offer({
    required this.id,
    required this.title,
    this.description,
    required this.discountPercentage,
    required this.originalPrice,
    required this.discountedPrice,
  });

  Offer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    discountPercentage = json['discountPercentage'] is int
        ? json['discountPercentage'].toDouble()
        : json['discountPercentage'];
    originalPrice = json['originalPrice'] is int
        ? json['originalPrice'].toDouble()
        : json['originalPrice'];
    discountedPrice = json['discountedPrice'] is int
        ? json['discountedPrice'].toDouble()
        : json['discountedPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['discountPercentage'] = discountPercentage;
    data['originalPrice'] = originalPrice;
    data['discountedPrice'] = discountedPrice;
    return data;
  }
}
