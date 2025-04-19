class PlantCareRuleCustom {
  final String id;
  final String customInstructions;

  PlantCareRuleCustom({
    required this.id,
    required this.customInstructions,
  });

  factory PlantCareRuleCustom.fromJson(Map<String, dynamic> json) {
    return PlantCareRuleCustom(
      id: json['id'] as String,
      customInstructions: json['custom_instructions'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'custom_instructions': customInstructions,
    };
  }
}