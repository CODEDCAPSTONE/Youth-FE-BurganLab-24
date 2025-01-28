class Target {
  String? id;
  String targetName;
  int balanceTarget;
  dynamic totalAmount;
  int duration;
  // String? income;
  dynamic monthlyDeduction;

  Target({
    this.id,
    required this.targetName,
    this.balanceTarget = 0,
    required this.totalAmount,
    required this.duration,
    // this.income,
    this.monthlyDeduction
  }); 

  Target.fromJson(Map<String, dynamic> json)
    : id = json['_id'] as String?,
      targetName = json['targetName'] as String,
      balanceTarget = json['balanceTarget'] as int,
      totalAmount = json['totalAmount'] as dynamic,
      duration = json['duration'] as int,
      // income = json['income'] as String,
      monthlyDeduction = json['monthlyDeduction'] as dynamic;
}