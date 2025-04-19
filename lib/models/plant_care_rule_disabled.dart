class PlantCareRuleDisabled {
  final String plantCareRuleId;
  final String accountId;

  PlantCareRuleDisabled({
    required this.plantCareRuleId,
    required this.accountId,
  });

  factory PlantCareRuleDisabled.fromJson(Map<String, dynamic> json) {
    return PlantCareRuleDisabled(
      plantCareRuleId: json['plant_care_rule_id'] as String,
      accountId: json['account_id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'plant_care_rule_id': plantCareRuleId,
      'account_id': accountId,
    };
  }
}