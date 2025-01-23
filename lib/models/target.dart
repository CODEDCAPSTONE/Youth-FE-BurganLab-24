class Target {
  String? id;
  String targetName;
  String balanceTarget;
  String totalAmount;
  int duration;
  String income;

  Target({
    this.id,
    required this.targetName,
    this.balanceTarget = "0",
    required this.totalAmount,
    required this.duration,
    required this.income
  }); 

  Target.fromJson(Map<String, dynamic> json)
    : id = json['_id'] as String?,
      targetName = json['targetName'] as String,
      balanceTarget = json['balanceTarget'] as String,
      totalAmount = json['totalAmount'] as String,
      duration = json['duration'] as int,
      income = json['income'] as String;
}