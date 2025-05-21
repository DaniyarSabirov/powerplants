import 'package:frontend/services/api_client.dart';
import '../models/home_group.dart';

class HomeGroupService {
  final ApiClient _client;

  HomeGroupService(this._client);

  Future<List<HomeGroup>> getGroupsByHomeId(String homeId) async {
    try {
      final response = await _client.get(
        '/homes/$homeId/groups',
      );

      if (response.statusCode == 200) {
        final List<dynamic> groupsJson = response.data as List<dynamic>;
        return groupsJson
            .map((json) => HomeGroup.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception(
          'Failed to load groups for home $homeId, status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching groups by home: $e');
    }
  }

  Future<HomeGroup> createGroup(String homeId, HomeGroup group) async {
    try {
      final response = await _client.post(
        'homes/$homeId/groups',
        data: group.toJson(),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return HomeGroup.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw Exception(
          'Failed to create group, status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error creating group: $e');
    }
  }

  Future<void> updateGroup(String homeId, String groupId, HomeGroup group) async {
    try {
      final response = await _client.put(
        'homes/$homeId/groups/$groupId',
        data: group.toJson(),
      );

      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception(
          'Failed to update group $groupId, status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error updating group: $e');
    }
  }

  Future<void> deleteGroup(String homeId, String groupId) async {
    try {
      final response = await _client.delete(
        'homes/$homeId/groups/$groupId',
      );

      if (response.statusCode == 204 || response.statusCode == 200) {
        return;
      } else {
        throw Exception(
          'Failed to delete group $groupId, status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error deleting group: $e');
    }
  }

  //
  // Not implemented on Backend
  //
  // Future<HomeGroup> getGroupById(String id) async {
  //   try {
  //     final response = await _client.get('/groups/$id'); // TODO check real endpoint
  //
  //     if (response.statusCode == 200) {
  //       return HomeGroup.fromJson(response.data as Map<String, dynamic>);
  //     } else {
  //       throw Exception(
  //         'Failed to load group data, status code: ${response.statusCode}',
  //       );
  //     }
  //   } catch (e) {
  //     throw Exception('Error fetching group: $e');
  //   }
  // }


}