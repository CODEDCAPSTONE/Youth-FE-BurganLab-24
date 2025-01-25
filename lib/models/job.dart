class Job {
  String? id;
  String titleJob;
  String description;
  bool isExpired;
  // String? user;

  Job({
    this.id,
    required this.titleJob,
    required this.description,
    required this.isExpired,
    // this.user
  });

  Job.fromJson(Map<String, dynamic> json)
    : id = json['_id'] as String?,
      titleJob = json['titleJob'] as String,
      description = json['description'] as String,
      isExpired = json['isExpired'] as bool;
      // user = json['user'] as String;
}