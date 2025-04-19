class Home {
  final String id;
  final String publicName;
  final String? description;

  Home({
    required this.id,
    required this.publicName,
    this.description,
  });

  factory Home.fromJson(Map<String, dynamic> json) {
    return Home(
      id: json['id'] as String,
      publicName: json['public_name'] as String,
      description: json['description'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'public_name': publicName,
      'description': description,
    };
  }
}