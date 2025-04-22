import 'package:frontend/services/api_client.dart';
import '../models/plant.dart';

class PlantService {
  final ApiClient _client;

  PlantService(this._client);

  Future<Plant> getPlantById(String id) async {
    try {
      final response = await _client.get('plants/$id'); // TODO check real endpoint

      if (response.statusCode == 200){
        return Plant.fromJson(response.data);
      } else {
        throw Exception('Failed to load plant data, error code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching plant: $e');
    }
  }

  Future<List<Plant>> getAllPlants() async {
    try {
      final response = await _client.get('/plants'); // TODO check real endpoint

      if (response.statusCode == 200) {
        List<dynamic> plantsJson = response.data;
        return plantsJson.map((json) => Plant.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load plants, error code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching all plants: $e');
    }
  }

  // Future<List<Plant>> getPlantsByGroupId(String groupId) async {  }
  //
  // Future<Plant> createPlant(Plant plant) async {  }
  //
  // Future<void> updatePlant(String id, Plant plant) async {  }
  //
  // Future<void> deletePlant(String id) async {  }


}