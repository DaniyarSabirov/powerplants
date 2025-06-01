import 'package:frontend/services/api_client.dart';
import '../models/home.dart';

class HomeService {
  final ApiClient _client;

  HomeService(this._client);

  Future<Home> getHomeById(String id) async {
    try {
      final response = await _client.get('/homes/$id');

      if (response.statusCode == 200) {
        return Home.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw Exception(
          'Failed to load home data, error code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching home: $e');
    }
  }

  Future<List<Home>> getAllHomes() async {
    try {
      final response = await _client.get('/homes');

      if (response.statusCode == 200) {
        final List<dynamic> homesJson = response.data as List<dynamic>;
        return homesJson
            .map((json) => Home.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception(
          'Failed to load homes, error code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching all homes: $e');
    }
  }

  Future<Home> createHome(Home home) async {
    try {
      final response = await _client.post(
        '/homes',
        data: home.toJson(),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final Map<String, dynamic> json = response.data as Map<String, dynamic>;
        return Home.fromJson(json);
      } else {
        throw Exception(
          'Failed to create home, status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error creating home: $e');
    }
  }

  Future<void> updateHome(String id, Home home) async {
    try {
      final response = await _client.put(
        '/homes/$id',
        data: home.toJson(),
      );

      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception(
          'Failed to update home with id $id, status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error updating home: $e');
    }
  }

  Future<void> deleteHome(String id) async {
    try {
      final response = await _client.delete(
        '/homes/$id',
      );

      if (response.statusCode == 204 || response.statusCode == 200) {
        return;
      } else {
        throw Exception(
          'Failed to delete home with id $id, status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error deleting home: $e');
    }
  }

  //
  // Not implemented on backend
  //
  // Future<List<Home>> getHomesByAccountId(String accountId) async {
  //   try {
  //     final response = await _client.get(
  //       '/accounts/$accountId/homes',
  //     ); // TODO check real endpoint
  //
  //     if (response.statusCode == 200) {
  //       final List<dynamic> homesJson = response.data as List<dynamic>;
  //       return homesJson
  //           .map((json) => Home.fromJson(json as Map<String, dynamic>))
  //           .toList();
  //     } else {
  //       throw Exception(
  //         'Failed to load homes for account $accountId, status code: ${response.statusCode}',
  //       );
  //     }
  //   } catch (e) {
  //     throw Exception('Error fetching homes by account: $e');
  //   }
  // }
}