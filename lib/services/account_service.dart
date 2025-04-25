import 'package:frontend/services/api_client.dart';
import '../models/account.dart';
import '../models/home.dart';

class AccountService {
  final ApiClient _client;

  AccountService(this._client);

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
          'Failed to load homes for account $accountId, status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching homes by account: $e');
    }
  }

  Future<List<Account>> getAllAccounts() async {
    try {
      final response = await _client.get(
          '/accounts'
      ); // TODO check real endpoint

      if (response.statusCode == 200) {
        final List<dynamic> accountsJson = response.data as List<dynamic>;
        return accountsJson
            .map((json) => Account.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception(
          'Failed to load accounts, error code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching all accounts: $e');
    }
  }

  Future<Account> getAccountById(String id) async {
    try {
      final response = await _client.get(
          '/accounts/$id'
      ); // TODO check real endpoint

      if (response.statusCode == 200) {
        return Account.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw Exception(
          'Failed to load account data, error code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching account: $e');
    }
  }

  Future<Account> createAccount(Account account) async {
    try {
      final response = await _client.post(
        '/accounts',
        data: account.toJson(),
      ); // TODO check real endpoint

      if (response.statusCode == 201 || response.statusCode == 200) {
        return Account.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw Exception(
          'Failed to create account, status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error creating account: $e');
    }
  }

  Future<void> updateAccount(String id, Account account) async {
    try {
      final response = await _client.put(
        '/accounts/$id',
        data: account.toJson(),
      ); // TODO check real endpoint

      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception(
          'Failed to update account with id $id, status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error updating account: $e');
    }
  }

  Future<void> deleteAccount(String id) async {
    try {
      final response = await _client.delete(
        '/accounts/$id',
      ); // TODO check real endpoint

      if (response.statusCode == 204 || response.statusCode == 200) {
        return;
      } else {
        throw Exception(
          'Failed to delete account with id $id, status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error deleting account: $e');
    }
  }
}