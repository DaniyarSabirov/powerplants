class HomeGroup {
  final String id;
  final String homeId;
  final String publicName;
  final String? description;
  final String? pictureUrl;

  HomeGroup({
    required this.id,
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
}