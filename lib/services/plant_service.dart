import 'package:frontend/services/api_client.dart';
import '../models/plant.dart';

class PlantService {
  final ApiClient _client;

  PlantService(this._client);

  Future<Plant> getPlantById(String id) async {
    try {
      final response = await _client.get(
        '/plants/$id',
      ); // TODO check real endpoint

      if (response.statusCode == 200) {
        return Plant.fromJson(response.data);
      } else {
        throw Exception(
          'Failed to load plant data, error code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching plant: $e');
    }
  }

  Future<List<Plant>> getAllPlants() async {
    try {
      final response = await _client.get('/plants'); // TODO check real endpoint

      if (response.statusCode == 200) {
        final List<dynamic> plantsJson = response.data as List<dynamic>;
        return plantsJson
            .map((json) => Plant.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception(
          'Failed to load plants, error code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching all plants: $e');
    }
  }

  Future<List<Plant>> getPlantsByGroupId(String groupId) async {
    try {
      final response = await _client.get(
        '/groups/$groupId/plants',
      ); // TODO check real endpoint

      if (response.statusCode == 200) {
        final List<dynamic> plantsJson = response.data as List<dynamic>;
        return plantsJson
            .map((json) => Plant.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception(
          'Failed to load plants for group $groupId, '
          'status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching plants by group: $e');
    }
  }

  Future<Plant> createPlant(Plant plant) async {
    try {
      final response = await _client.post(
        '/plants',
        data: plant.toJson(),
      ); // TODO check real endpoint

      if (response.statusCode == 201 || response.statusCode == 200) {
        final Map<String, dynamic> json = response.data as Map<String, dynamic>;
        return Plant.fromJson(json);
      } else {
        throw Exception(
          'Failed to create plant, status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error creating plant: $e');
    }
  }

  Future<void> updatePlant(String id, Plant plant) async {
    try {
      final response = await _client.put(
        '/plants/$id',
        data: plant.toJson(),
      ); // TODO check real endpoint

      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception(
          'Failed to update plant with id $id, status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error updating plant: $e');
    }
  }

  Future<void> deletePlant(String id) async {
    try {
      final response = await _client.delete(
        '/plants/$id',
      ); // TODO check real endpoint

      if (response.statusCode == 204 || response.statusCode == 200) {
        return;
      } else {
        throw Exception(
          'Failed to delete plant with id $id, status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error deleting plant: $e');
    }
  }
}
