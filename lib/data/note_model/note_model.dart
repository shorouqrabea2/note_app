class CreateNoteModel {
  final String headline;
  final String description;
  final DateTime createdAt;

  CreateNoteModel({
    required this.headline,
    required this.description,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'headline': headline,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory CreateNoteModel.fromJson(Map<String, dynamic> json) {
    return CreateNoteModel(
      headline: json['headline'] as String,
      description: json['description'] as String,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
