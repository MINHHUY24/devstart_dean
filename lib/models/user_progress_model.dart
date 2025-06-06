class UserProgress {
  final int id;
  final String userId;
  final String courseName;
  final int unlockedLevel;
  final DateTime updatedAt;

  UserProgress({
    required this.id,
    required this.userId,
    required this.courseName,
    required this.unlockedLevel,
    required this.updatedAt,
  });

  factory UserProgress.fromJson(Map<String, dynamic> json) {
    return UserProgress(
      id: json['id'] as int,
      userId: json['user_id'] as String,
      courseName: json['course_name'] as String,
      unlockedLevel: json['unlocked_level'] as int,
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'course_name': courseName,
      'unlocked_level': unlockedLevel,
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
