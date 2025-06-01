import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:frontend/services/api_client.dart';
import 'package:http_parser/http_parser.dart';
import '../models/plant.dart';

class PlantService {
  final ApiClient _client;

  PlantService(this._client);

  Future<Plant> getPlantById(String groupId, String plantId) async {
    try {
      final response = await _client.get(
        '/groups/$groupId/plants/$plantId',
      );

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

  Future<List<Plant>> getPlantsByGroupId(String groupId) async {
    try {
      final response = await _client.get(
        '/groups/$groupId/plants',
      );

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

  Future<Plant> createPlant(Plant plant, File? image) async {
    try {
      final formData = FormData.fromMap({
        'plant': MultipartFile.fromString(
          jsonEncode(plant.toJson()),
          contentType: MediaType('application', 'json'),
        ),
        if (image != null)
          'image': await MultipartFile.fromFile(
            image.path,
            filename: image.path.split('/').last,
            contentType: MediaType('image', 'jpeg'), // or 'image/png'
          ),
      });

      final response = await _client.post(
        '/groups/${plant.groupId}/plants',
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return Plant.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw Exception(
          'Failed to create plant, status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error creating plant: $e');
    }
  }

  Future<Plant> updatePlant(String groupId, String plantId, Plant plant, File? image) async {
    try {
      final formData = FormData.fromMap({
        'plant': MultipartFile.fromString(
          jsonEncode(plant.toJson()),
          contentType: MediaType('application', 'json'),
        ),
        if (image != null)
          'image': await MultipartFile.fromFile(
            image.path,
            filename: image.path.split('/').last,
            contentType: MediaType('image', 'jpeg'), // or 'image/png'
          ),
      });

      final response = await _client.put(
        '/groups/$groupId/plants/$plantId',
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
        ),
      );

      if (response.statusCode == 200) {
        return Plant.fromJson(response.data);
      } else {
        throw Exception(
          'Failed to update plant with id $plantId, status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error updating plant: $e');
    }
  }

  Future<void> deletePlant(String groupId, String plantId) async {
    try {
      final response = await _client.delete(
        '/groups/$groupId/plants/$plantId',
      );

      if (response.statusCode == 204 || response.statusCode == 200) {
        return;
      } else {
        throw Exception(
          'Failed to delete plant with id $plantId, status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error deleting plant: $e');
    }
  }
}

//
// Not implemented on Backend
//
// Future<List<Plant>> getAllPlants() async {
//   try {
//     final response = await _client.get('/plants');
//
//     if (response.statusCode == 200) {
//       final List<dynamic> plantsJson = response.data as List<dynamic>;
//       return plantsJson
//           .map((json) => Plant.fromJson(json as Map<String, dynamic>))
//           .toList();
//     } else {
//       throw Exception(
//         'Failed to load plants, error code: ${response.statusCode}',
//       );
//     }
//   } catch (e) {
//     throw Exception('Error fetching all plants: $e');
//   }
// }
