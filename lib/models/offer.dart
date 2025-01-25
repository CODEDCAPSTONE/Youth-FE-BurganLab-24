class Offer {
  String? id;
  String name;
  String description;
  int discount;

  Offer({
    this.id,
    required this.name,
    required this.description,
    required this.discount
  });

  Offer.fromJson(Map<String, dynamic> json)
    : id = json['_id'] as String?,
      name = json['name'] as String,
      description = json['description'] as String,
      discount = json['discount'] as int;
}