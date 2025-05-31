import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:frontend/services/api_client.dart';
import 'package:http_parser/http_parser.dart';
import '../models/account.dart';

class AccountService {
  final ApiClient _client;

  AccountService(this._client);

  Future<List<Account>> getAllAccounts() async {
    try {
      final response = await _client.get(
          '/accounts'
      );

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
      );

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

  Future<Account> createAccount(Account account, File? image) async {
    try {
      final formData = FormData.fromMap({
        'account': MultipartFile.fromString(
          jsonEncode(account.toJson()),
          contentType: MediaType('application', 'json'),
        ),
        if (image != null)
          'image': await MultipartFile.fromFile(
            image.path,
            filename: image.path.split('/').last,
            contentType: MediaType('image', 'jpeg'), // или image/png
          ),
      });

      final response = await _client.post(
        '/accounts',
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
        ),
      );

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


  Future<Account> updateAccount(String id, Account account, File? image) async {
    try {
      final formData = FormData.fromMap({
        'account': MultipartFile.fromString(
          jsonEncode(account.toJson()),
          contentType: MediaType('application', 'json'),
        ),
        if (image != null)
          'image': await MultipartFile.fromFile(
            image.path,
            filename: image.path.split('/').last,
            contentType: MediaType('image', 'jpeg'), // или image/png
          ),
      });

      final response = await _client.put(
        '/accounts/$id',
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
        ),
      );

      if (response.statusCode == 200) {
        return Account.fromJson(response.data as Map<String, dynamic>);
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
      );

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

  Future<void> addHomeToAccount(String accountId, String homeId) async {
    try {
      final response = await _client.post(
        '/accounts/$accountId/homes/$homeId',
      );

      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception(
          'Failed to add home $homeId to account $accountId, status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error adding home to account: $e');
    }
  }


  //
  //  Not implemented on backend
  //
  // Future<List<Account>> getAccountsByHomeId(String homeId) async {
  //   try {
  //     final response = await _client.get(
  //       '/homes/$homeId/accounts',
  //     ); // TODO check real endpoint
  //
  //     if (response.statusCode == 200) {
  //       final List<dynamic> accountsJson = response.data as List<dynamic>;
  //       return accountsJson
  //           .map((json) => Account.fromJson(json as Map<String, dynamic>))
  //           .toList();
  //     } else {
  //       throw Exception(
  //         'Failed to load accounts for home $homeId, status code: ${response.statusCode}',
  //       );
  //     }
  //   } catch (e) {
  //     throw Exception('Error fetching accounts by home: $e');
  //   }
  // }
}