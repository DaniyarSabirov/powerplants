class PlantCareRuleWater {
  final String id;
  final int amount;

  PlantCareRuleWater({
    required this.id,
    required this.amount,
  });

  factory PlantCareRuleWater.fromJson(Map<String, dynamic> json) {
    return PlantCareRuleWater(
      id: json['id'] as String,
      amount: json['amount'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
    };
  }
}