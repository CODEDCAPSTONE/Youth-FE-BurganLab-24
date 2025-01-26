class Target {
  String? id;
  String targetName;
  int balanceTarget;
  int totalAmount;
  int duration;
  String income;

  Target({
    this.id,
    required this.targetName,
    this.balanceTarget = 0,
    required this.totalAmount,
    required this.duration,
    required this.income
  }); 

  Target.fromJson(Map<String, dynamic> json)
    : id = json['_id'] as String?,
      targetName = json['targetName'] as String,
      balanceTarget = json['balanceTarget'] as int,
      totalAmount = json['totalAmount'] as int,
      duration = json['duration'] as int,
      income = json['income'] as String;
}