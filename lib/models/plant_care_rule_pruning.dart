class PlantCareRulePruning {
  final String id;
  final String amount;

  PlantCareRulePruning({
    required this.id,
    required this.amount,
  });

  factory PlantCareRulePruning.fromJson(Map<String, dynamic> json) {
    return PlantCareRulePruning(
      id: json['id'] as String,
      amount: json['amount'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
    };
  }
}