class User {
  int? id;
  String username;
  String? password;
  double balance;

  User({
    this.id,
    required this.username,
    this.password,
    this.balance = 0.0,
  });

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        username = json['username'] as String,
        password = json['password'] as String,
        balance = json['balance'] as double;
        
  Map<String, dynamic> toJson() {
    return <String, dynamic>{'username': username, 'password': password};
  }
}
