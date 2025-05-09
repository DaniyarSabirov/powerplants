class Home {
  final String id;
  final String publicName;
  final String? description;

  Home({
    this.id,
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

  Home copyWith({
    String? id,
    String? publicName,
    String? description,
  }) {
    return Home(
      id: id ?? this.id,
      publicName: publicName ?? this.publicName,
      description: description ?? this.description,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Home) return false;
    return other.id == id &&
        other.publicName == publicName;
  }

  @override
  int get hashCode {
    return id.hashCode ^ publicName.hashCode;
  }

  @override
  String toString() {
    return 'Home{id: $id,'
        'publicName: $publicName,'
        'description: $description}';
  }
}