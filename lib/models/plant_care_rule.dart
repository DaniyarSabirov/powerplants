class PlantCareRule {
  final String id;
  final String plantId;
  final String publicName;
  final bool enabled;
  final String cron;
  final String? instructions;

  PlantCareRule({
    required this.id,
    required this.plantId,
    required this.publicName,
    required this.enabled,
    required this.cron,
    this.instructions,
  });

  factory PlantCareRule.fromJson(Map<String, dynamic> json) {
    return PlantCareRule(
      id: json['id'] as String,
      plantId: json['plant_id'] as String,
      publicName: json['public_name'] as String,
      enabled: json['enabled'] as bool,
      cron: json['cron'] as String,
      instructions: json['instructions'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'plant_id': plantId,
      'public_name': publicName,
      'enabled': enabled,
      'cron': cron,
      'instructions': instructions,
    };
  }

  PlantCareRule copyWith({
    String? id,
    String? plantId,
    String? publicName,
    bool? enabled,
    String? cron,
    String? instructions,
  }) {
    return PlantCareRule(
      id: id ?? this.id,
      plantId: plantId ?? this.plantId,
      publicName: publicName ?? this.publicName,
      enabled: enabled ?? this.enabled,
      cron: cron ?? this.cron,
      instructions: instructions ?? this.instructions,
    );
  }

  @override
  bool operator ==(Object other) =>
    identical (this, other) ||
      other is PlantCareRule &&
        other.id == id &&
        other.plantId == plantId;


  @override
  int get hashCode =>
      id.hashCode ^ plantId.hashCode;

  @override
  String toString() {
    return 'PlantCareRule('
        'id: $id, '
        'plantId: $plantId, '
        'publicName: $publicName, '
        'enabled: $enabled, '
        'cron: $cron, '
        'instructions: $instructions'
        ')';
  }
}
