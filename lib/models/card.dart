
class VCard {
  String? id;
  String? name;
  int cardNumber;
  String expiryDate;
  int cvv;
  bool? typeDebit;
  dynamic balance = 0;
  int? limit;

  VCard(
      {
        this.id,
        this.name,
        required this.cardNumber,
        required this.expiryDate,
        required this.cvv,
        this.typeDebit,
        this.balance,
        // this.transactions,
        this.limit
      }
    );

  VCard.fromJson(Map<String, dynamic> json)
      : id = json['_id'] as String?,
        name = json['name'] as String?,
        cardNumber = json['cardNumber'] as int,
        expiryDate = json['expiryDate'] as String,
        cvv = json['cvv'] as int,
        typeDebit = json['typeDebit'] as bool?,
        balance = json['balance'] as dynamic,
        limit = json['limit'] as int?;
}
