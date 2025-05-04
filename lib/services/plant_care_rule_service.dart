import 'package:frontend/services/api_client.dart';
import '../models/plant_care_rule.dart';

class PlantCareRuleService {
  final ApiClient _client;

  PlantCareRuleService(this._client);

  Future<List<PlantCareRule>> getRulesByPlantId(String plantId) async {
    try {
      final response = await _client.get(
          '/plants/$plantId/rules'
      ); // TODO check real endpoint

      if (response.statusCode != 200) {
        throw Exception('Failed to load rules: ${response.statusCode}');
      }
      final List<dynamic> data = response.data as List<dynamic>;
      return data
          .map((json) => PlantCareRule.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Error fetching rules for plant $plantId: $e');
    }
  }

  Future<List<PlantCareRule>> getAllRules() async {
    try {
      final response = await _client.get(
        '/rules'
      ); // TODO check real endpoint

      if (response.statusCode != 200){
        throw Exception ('Failed to load all rules: ${response.statusCode}');
      }
      final List<dynamic> data = response.data as List<dynamic>;
      return data
          .map((json) => PlantCareRule.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Error fetching all rules: $e');
    }
  }

  Future<PlantCareRule> createRule(String plantId, PlantCareRule rule) async {
    try {
      final response = await _client.post(
        '/plants/$plantId/rules',
        data: rule.toJson(),
      ); // TODO check real endpoint

      if (response.statusCode != 201) {
        throw Exception('Failed to create rule: ${response.statusCode}');
      }
      return PlantCareRule.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Error creating rule for plant $plantId: $e');
    }
  }

  Future<void> updateRule(PlantCareRule rule) async {
    try {
      final response = await _client.put(
        '/rules/${rule.id}',
        data: rule.toJson(),
      ); // TODO check real endpoint

      if (response.statusCode != 204 && response.statusCode != 200) {
        throw Exception(
          'Failed to update rule ${rule.id}: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error updating rule ${rule.id}: $e');
    }
  }

  Future<PlantCareRule> getRuleById(String ruleId) async {
    try {
      final response = await _client.get(
          '/rules/$ruleId'
      ); // TODO check real endpoint

      if (response.statusCode != 200){
        throw Exception('Failed to load rule with id $ruleId: ${response.statusCode}');
      }
      return PlantCareRule.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Error fetching rule with id $ruleId: $e');
    }
  }

  Future<void> deleteRule(String ruleId) async {
    try {
      final response = await _client.delete(
          '/rules/$ruleId'
      ); // TODO check real endpoint

      if (response.statusCode != 204 && response.statusCode != 200) {
        throw Exception(
          'Failed to delete rule $ruleId: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error deleting rule $ruleId: $e');
    }
  }
}