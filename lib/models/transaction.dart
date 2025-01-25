class Transaction {
  String? id;
  String name;
  double amount;
  String category;
  String date;

  Transaction({
    this.id,
    required this.name,
    required this.amount,
    required this.category,
    required this.date
  });

  Transaction.fromJson(Map<String, dynamic> json)
    : id = json['_id'] as String?,
      name = json['name'] as String,
      amount = json['amount'] as double,
      category = json['category'] as String,
      date = json['date'] as String;
}