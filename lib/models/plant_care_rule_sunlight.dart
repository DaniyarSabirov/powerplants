class PlantCareRuleSunlight {
  final String id;
  final int duration;

  PlantCareRuleSunlight({
    required this.id,
    required this.duration,
  });

  factory PlantCareRuleSunlight.fromJson(Map<String, dynamic> json) {
    return PlantCareRuleSunlight(
      id: json['id'] as String,
      duration: json['duration'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'duration': duration,
    };
  }
}