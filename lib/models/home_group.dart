class HomeGroup {
  final String id;
  final String homeId;
  final String publicName;
  final String? description;
  final String? pictureUrl;

  HomeGroup({
    this.id,
    required this.homeId,
    required this.publicName,
    this.description,
    this.pictureUrl,
  });

  factory HomeGroup.fromJson(Map<String, dynamic> json) {
    return HomeGroup(
      id: json['id'] as String,
      homeId: json['home_id'] as String,
      publicName: json['public_name'] as String,
      description: json['description'] as String?,
      pictureUrl: json['picture_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'home_id': homeId,
      'public_name': publicName,
      'description': description,
      'picture_url': pictureUrl,
    };
  }

  HomeGroup copyWith({
    String? id,
    String? homeId,
    String? publicName,
    String? description,
    String? pictureUrl,
  }) {
    return HomeGroup(
      id: id ?? this.id,
      homeId: homeId ?? this.homeId,
      publicName: publicName ?? this.publicName,
      description: description ?? this.description,
      pictureUrl: pictureUrl ?? this.pictureUrl,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! HomeGroup) return false;
    return other.id == id &&
        other.homeId == homeId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
    homeId.hashCode;
  }

  @override
  String toString() {
    return 'HomeGroup{id: $id, homeId: $homeId, publicName: $publicName, description: $description, pictureUrl: $pictureUrl}';
  }
}