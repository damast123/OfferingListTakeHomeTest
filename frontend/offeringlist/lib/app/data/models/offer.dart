class Offer {
  String? id;
  String? title;
  String? description;
  double? discountPercentage;
  double? originalPrice;
  double? discountedPrice;

  Offer({
    this.id,
    this.title,
    this.description,
    this.discountPercentage,
    this.originalPrice,
    this.discountedPrice,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      discountPercentage: json['discountPercentage'] is int
          ? json['discountPercentage'].toDouble()
          : json['discountPercentage'],
      originalPrice: json['originalPrice'] is int
          ? json['originalPrice'].toDouble()
          : json['originalPrice'],
      discountedPrice: json['discountedPrice'] is int
          ? json['discountedPrice'].toDouble()
          : json['discountedPrice'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['discountPercentage'] = discountPercentage;
    data['originalPrice'] = originalPrice;
    data['discountedPrice'] = discountedPrice;
    return data;
  }
}
