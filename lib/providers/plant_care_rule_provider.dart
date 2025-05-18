import 'package:flutter/cupertino.dart';
import 'package:frontend/models/plant_care_rule.dart';
import 'package:frontend/services/plant_care_rule_service.dart';

class PlantCareRuleProvider extends ChangeNotifier {
  final PlantCareRuleService _ruleService;
  List<PlantCareRule> _rules = [];
  bool _isLoading = false;
  String? _error;
  PlantCareRule? _selectedRule;

  List<PlantCareRule> get rules => _rules;
  bool get isLoading => _isLoading;
  String? get error => _error;
  PlantCareRule? get selectedRule => _selectedRule;

  PlantCareRuleProvider(this._ruleService);

  // Wrapper-method for performing async operations and throwing exceptions connected with backend
  // instead of using _error  = ... and notifyListeners in every method
  Future<void> _handleAsync(Future<void> Function() operation) async {
    _error = null;
    notifyListeners();

    try {
      await operation();
    } catch (e) {
      _error = 'Operation failed: $e';
      notifyListeners();
      throw Exception(_error);
    }
  }

  Future<void> loadRulesByPlantId(String plantId) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _handleAsync(() async {
        _rules = await _ruleService.getRulesByPlantId(plantId);
      });
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadAllRules() async {
    _isLoading = true;
    notifyListeners();

    try {
      await _handleAsync(() async {
        _rules = await _ruleService.getAllRules();
      });
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addRule(String plantId, PlantCareRule rule) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _handleAsync(() async {
        final newRule = await _ruleService.createRule(plantId, rule);
        _rules.add(newRule);
      });
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateRule(PlantCareRule rule) async {
    await _handleAsync(() async {
      final index = _rules.indexWhere((r) => r.id == rule.id);
      if (index == -1) {
        _error = 'Rule with ID ${rule.id} not found in local list';
        notifyListeners();
        throw Exception(_error);
      }

      if (rule.id == null) {
        _error = 'Rule ID is null';
        notifyListeners();
        throw Exception(_error);
      }

      await _ruleService.updateRule(rule);
      _rules[index] = rule;
      notifyListeners();
    });
  }

  Future<void> loadRuleById(String ruleId) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _handleAsync(() async {
        _selectedRule = await _ruleService.getRuleById(ruleId);
      });
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteRule(String ruleId) async {
    final index = _rules.indexWhere((r) => r.id == ruleId);
    if (index == -1) return;

    final removedRule = _rules.removeAt(index);
    notifyListeners();

    try {
      await _handleAsync(() async {
        await _ruleService.deleteRule(ruleId);
      });
    } catch (_) {
      _rules.insert(index, removedRule); // rollback
      notifyListeners();
      rethrow;
    }
  }
}
