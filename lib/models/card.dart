
class VCard {
  String? id;
  String name;
  int cardNumber;
  String expiryDate;
  int cvv;
  int? balance;
  int? limit;

  VCard(
      {
        this.id,
        required this.name,
        required this.cardNumber,
        required this.expiryDate,
        required this.cvv,
        this.balance,
        // this.transactions,
        this.limit
      }
    );

  VCard.fromJson(Map<String, dynamic> json)
      : id = json['_id'] as String?,
        name = json['name'] as String,
        cardNumber = json['cardNumber'] as int,
        expiryDate = json['expiryDate'] as String,
        cvv = json['cvv'] as int,
        balance = json['balance'] as int,
        limit = json['limit'] as int;
}
