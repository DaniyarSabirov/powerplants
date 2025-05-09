sealed class PlantCareRule {
  final String id;
  final String publicName;
  final bool enabled;
  final String cron;
  final String instructions;

  const PlantCareRule({
    this.id,
    required this.publicName,
    required this.enabled,
    required this.cron,
    required this.instructions,
  });

  factory PlantCareRule.fromJson(Map<String, dynamic> json) {
    if(json['type'] == null){
      throw ArgumentError('Missing "type filed in JSON"');
    }

    switch (json['type'] as String) {
      case 'custom':
        return CustomRule(
          id: json['id'] as String,
          publicName: json['publicName'] as String,
          enabled: json['enabled'] as bool,
          cron: json['cron'] as String,
          instructions: json['instructions'] as String,
          customInstructions: json['customInstructions'] as String,
        );
      case 'water':
        return WaterRule(
          id: json['id'] as String,
          publicName: json['publicName'] as String,
          enabled: json['enabled'] as bool,
          cron: json['cron'] as String,
          instructions: json['instructions'] as String,
          amount: json['amount'] as int,
        );
      case 'sunlight':
        return SunlightRule(
          id: json['id'] as String,
          publicName: json['publicName'] as String,
          enabled: json['enabled'] as bool,
          cron: json['cron'] as String,
          instructions: json['instructions'] as String,
          duration: json['duration'] as int,
        );
      case 'pruning':
        return PruningRule(
          id: json['id'] as String,
          publicName: json['publicName'] as String,
          enabled: json['enabled'] as bool,
          cron: json['cron'] as String,
          instructions: json['instructions'] as String,
          amount: json['amount'] as String,
        );
      case 'done':
        return DoneRule(
          id: json['id'] as String,
          publicName: json['publicName'] as String,
          enabled: json['enabled'] as bool,
          cron: json['cron'] as String,
          instructions: json['instructions'] as String,
          completedBy: json['completed_by'] as String,
          details: json['details'] as String,
          completedAt: json['completed_at'] as DateTime,
        );
      default:
        throw UnsupportedError('Unknown PlantCareRule type: ${json['type']}');
    }
  }

  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
    other is PlantCareRule &&
    id == other.id &&
    publicName == other.publicName;

  @override
  int get hashCode =>
  id.hashCode ^ publicName.hashCode;
}



final class CustomRule extends PlantCareRule {
  final String customInstructions;

  const CustomRule({
    super.id,
    required super.publicName,
    required super.enabled,
    required super.cron,
    required super.instructions,
    required this.customInstructions,
  });

  @override
  Map<String, dynamic> toJson() => {
    'type': 'custom',
    'id': id,
    'publicName': publicName,
    'enabled': enabled,
    'cron': cron,
    'instructions': instructions,
    'customInstructions': customInstructions,
  };

  CustomRule copyWith({
    String? id,
    String? publicName,
    bool? enabled,
    String? cron,
    String? instructions,
    String? customInstructions,
  }) {
    return CustomRule(
      id: id ?? this.id,
      publicName: publicName ?? this.publicName,
      enabled: enabled ?? this.enabled,
      cron: cron ?? this.cron,
      instructions: instructions ?? this.instructions,
      customInstructions: customInstructions ?? this.customInstructions,
    );
  }

  @override
  String toString() {
    return 'CustomRule(id: $id,'
        'publicName: $publicName,'
        'enabled: $enabled,'
        'cron: $cron,'
        'instructions: $instructions,'
        'customInstructions: $customInstructions)';
  }
}



final class WaterRule extends PlantCareRule {
  final int amount;

  const WaterRule({
    super.id,
    required super.publicName,
    required super.enabled,
    required super.cron,
    required super.instructions,
    required this.amount,
  });

  @override
  Map<String, dynamic> toJson() => {
    'type': 'water',
    'id': id,
    'publicName': publicName,
    'enabled': enabled,
    'cron': cron,
    'instructions': instructions,
    'amount': amount,
  };

  WaterRule copyWith({
    String? id,
    String? publicName,
    bool? enabled,
    String? cron,
    String? instructions,
    int? amount,
  }) {
    return WaterRule(
      id: id ?? this.id,
      publicName: publicName ?? this.publicName,
      enabled: enabled ?? this.enabled,
      cron: cron ?? this.cron,
      instructions: instructions ?? this.instructions,
      amount: amount ?? this.amount,
    );
  }

  @override
  String toString() {
    return 'WaterRule(id: $id,'
        'publicName: $publicName,'
        'enabled: $enabled,'
        'cron: $cron,'
        'instructions: $instructions,'
        'amount: $amount)';
  }
}



final class SunlightRule extends PlantCareRule {
  final int duration;

  const SunlightRule({
    super.id,
    required super.publicName,
    required super.enabled,
    required super.cron,
    required super.instructions,
    required this.duration,
  });

  @override
  Map<String, dynamic> toJson() =>
      {
        'type': 'sunlight',
        'id': id,
        'publicName': publicName,
        'enabled': enabled,
        'cron': cron,
        'instructions': instructions,
        'duration': duration,
      };

  SunlightRule copyWith({
    String? id,
    String? publicName,
    bool? enabled,
    String? cron,
    String? instructions,
    int? duration,
  }) {
    return SunlightRule(
      id: id ?? this.id,
      publicName: publicName ?? this.publicName,
      enabled: enabled ?? this.enabled,
      cron: cron ?? this.cron,
      instructions: instructions ?? this.instructions,
      duration: duration ?? this.duration,
    );
  }

  @override
  String toString() {
    return 'SunlightRule(id: $id,'
        'publicName: $publicName,'
        'enabled: $enabled,'
        'cron: $cron,'
        'instructions: $instructions,'
        'duration: $duration)';
  }
}



final class PruningRule extends PlantCareRule {
  final String amount;

  const PruningRule({
    super.id,
    required super.publicName,
    required super.enabled,
    required super.cron,
    required super.instructions,
    required this.amount,
  });

  @override
  Map<String, dynamic> toJson() =>
      {
        'type': 'pruning',
        'id': id,
        'publicName': publicName,
        'enabled': enabled,
        'cron': cron,
        'instructions': instructions,
        'amount': amount,
      };

  PruningRule copyWith({
    String? id,
    String? publicName,
    bool? enabled,
    String? cron,
    String? instructions,
    String? amount,
  }) {
    return PruningRule(
      id: id ?? this.id,
      publicName: publicName ?? this.publicName,
      enabled: enabled ?? this.enabled,
      cron: cron ?? this.cron,
      instructions: instructions ?? this.instructions,
      amount: amount ?? this.amount,
    );
  }

  @override
  String toString() {
    return 'PruningRule(id: $id,'
        'publicName: $publicName,'
        'enabled: $enabled,'
        'cron: $cron,'
        'instructions: $instructions,'
        'amount: $amount)';
  }
}



final class DoneRule extends PlantCareRule {
  final String completedBy;
  final String details;
  final DateTime completedAt;

  const DoneRule({
    super.id,
    required super.publicName,
    required super.enabled,
    required super.cron,
    required super.instructions,
    required this.completedBy,
    required this.details,
    required this.completedAt,
  });

  @override
  Map<String, dynamic> toJson() =>
      {
        'type': 'done',
        'id': id,
        'publicName': publicName,
        'enabled': enabled,
        'cron': cron,
        'instructions': instructions,
        'completedBy': completedBy,
        'details': details,
        'completedAt': completedAt.toIso8601String(),
      };

  DoneRule copyWith({
    String? id,
    String? publicName,
    bool? enabled,
    String? cron,
    String? instructions,
    String? completedBy,
    String? details,
    DateTime? completedAt,
  }) {
    return DoneRule(
      id: id ?? this.id,
      publicName: publicName ?? this.publicName,
      enabled: enabled ?? this.enabled,
      cron: cron ?? this.cron,
      instructions: instructions ?? this.instructions,
      completedBy: completedBy ?? this.completedBy,
      details: details ?? this.details,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  @override
  String toString() {
    return 'DoneRule(id: $id,'
        'publicName: $publicName,'
        'enabled: $enabled,'
        'cron: $cron,'
        'instructions: $instructions,'
        'completedBy: $completedBy,'
        'details: $details,'
        'completedAt: $completedAt)';
  }
}



final class DisabledRule extends PlantCareRule {
  final String disabledBy;
  final DateTime disabledAt;

  const DisabledRule({
    super.id,
    required super.publicName,
    required super.enabled,
    required super.cron,
    required super.instructions,
    required this.disabledBy,
    required this.disabledAt,
  });

  @override
  Map<String, dynamic> toJson() =>
      {
        'type': 'disabled',
        'id': id,
        'publicName': publicName,
        'enabled': enabled,
        'cron': cron,
        'instructions': instructions,
        'disabledBy': disabledBy,
        'disabledAt': disabledAt.toIso8601String(),
      };

  DisabledRule copyWith({
    String? id,
    String? publicName,
    bool? enabled,
    String? cron,
    String? instructions,
    String? disabledBy,
    DateTime? disabledAt,
  }) {
    return DisabledRule(
      id: id ?? this.id,
      publicName: publicName ?? this.publicName,
      enabled: enabled ?? this.enabled,
      cron: cron ?? this.cron,
      instructions: instructions ?? this.instructions,
      disabledBy: disabledBy ?? this.disabledBy,
      disabledAt: disabledAt ?? this.disabledAt,
    );
  }

  @override
  String toString() {
    return 'DisabledRule(id: $id,'
        'publicName: $publicName,'
        'enabled: $enabled,'
        'cron: $cron,'
        'instructions: $instructions,'
        'disabledBy: $disabledBy,'
        'disabledAt: $disabledAt)';
  }
}