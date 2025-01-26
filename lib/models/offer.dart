class Offer {
  String? id;
  String offerName;
  String description;
  int discount;

  Offer({
    this.id,
    required this.offerName,
    required this.description,
    required this.discount
  });

  Offer.fromJson(Map<String, dynamic> json)
    : id = json['_id'] as String?,
      offerName = json['offerName'] as String,
      description = json['description'] as String,
      discount = json['discount'] as int;
}