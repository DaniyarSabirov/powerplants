class PlantCareDone {
  final String id;
  final String plantId;
  final String plantCareRuleId;
  final String completedBy;
  final DateTime completedAt;
  final String? details;

  PlantCareDone({
    required this.id,
    required this.plantId,
    required this.plantCareRuleId,
    required this.completedBy,
    required this.completedAt,
    this.details,
  });

  factory PlantCareDone.fromJson(Map<String, dynamic> json) {
    return PlantCareDone(
      id: json['id'] as String,
      plantId: json['plant_id'] as String,
      plantCareRuleId: json['plant_care_rule_id'] as String,
      completedBy: json['completed_by'] as String,
      completedAt: DateTime.parse(json['completed_at'] as String),
      details: json['details'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'plant_id': plantId,
      'plant_care_rule_id': plantCareRuleId,
      'completed_by': completedBy,
      'completed_at': completedAt.toIso8601String(),
      'details': details,
    };
  }
}