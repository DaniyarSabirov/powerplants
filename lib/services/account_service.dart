import 'package:frontend/services/api_client.dart';

class AccountService {
  final ApiClient _client;

  // this method is tied with homes, recheck, proably leave it here in this class
  Future<List<Home>> getHomesByAccountId(String accountId) async {
    try {
      final response = await _client.get(
        '/accounts/$accountId/homes',
      ); // TODO check real endpoint

      if (response.statusCode == 200) {
        final List<dynamic> homesJson = response.data as List<dynamic>;
        return homesJson
            .map((json) => Home.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception(
          'Failed to load homes for account $accountId, status code: ${response
              .statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching homes by account: $e');
    }
  }

}