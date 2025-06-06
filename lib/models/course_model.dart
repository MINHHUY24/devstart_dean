class CourseModel {
  final int id;
  final String name;
  final String imageUrl;
  final String description;
  final int progress;
  final String status;

  CourseModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.progress,
    required this.status,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    print('CourseModel JSON: $json');
    return CourseModel(
      id: json['id'] as int,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] == null ? '' : json['imageUrl'].toString(),
      description: json['description'] == null ? '' : json['description'].toString(),
      progress: json['progress'] as int,
      status: json['status'] == null ? '' : json['status'].toString(),

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image_url': imageUrl,
      'description': description,
      'progress': progress,
      'status': status,
    };
  }
}
