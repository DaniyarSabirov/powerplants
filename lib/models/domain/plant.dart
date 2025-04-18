class Plant {
  final String id;
  final String name;
  final String scientificName;
  final String? description;
  final String? imageUrl;
  final String groupId;

  Plant({
    required this.id,
    required this.name,
    required this.scientificName,
    this.description,
    this.imageUrl,
    required this.groupId,
  });

  factory Plant.fromJson(Map<String, dynamic> json) => Plant(
    id: json['id'],
    name: json['name'],
    scientificName: json['scientificName'],
    description: json['description'],
    imageUrl: json['imageUrl'],
    groupId: json['groupId'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'scientificName': scientificName,
    'description': description,
    'imageUrl': imageUrl,
    'groupId': groupId,
  };

  Plant copyWith({
    String? id,
    String? name,
    String? scientificName,
    String? description,
    String? imageUrl,
    String? groupId,
  }) {
    return Plant(
      id: id ?? this.id,
      name: name ?? this.name,
      scientificName: scientificName ?? this.scientificName,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      groupId: groupId ?? this.groupId,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Plant &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              groupId == other.groupId;

  @override
  int get hashCode =>
      id.hashCode ^ groupId.hashCode;

  // Debug print
  @override
  String toString() {
    return 'Plant(id: $id, name: $name, scientificName: $scientificName, description: $description, imageUrl: $imageUrl, groupId: $groupId)';
  }
}
