import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:frontend/models/account.dart';
import 'package:frontend/services/account_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountProvider extends ChangeNotifier {
  static const String _loggedInAccountKey = 'logged_in_account_id';

  final AccountService _accountService;
  List<Account> _accounts = [];
  bool _isLoading = false;
  String? _error;
  Account? _selectedAccount;

  // Temporary local avatar file (for quick update before upload)
  File? _tempAvatar;

  List<Account> get accounts => _accounts;
  bool get isLoading => _isLoading;
  String? get error => _error;
  Account? get selectedAccount => _selectedAccount;
  File? get tempAvatar => _tempAvatar;

  AccountProvider(this._accountService);

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

  Future<void> loadAllAccounts() async {
    _isLoading = true;
    notifyListeners();

    try {
      await _handleAsync(() async {
        _accounts = await _accountService.getAllAccounts();
      });
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadAccountById(String id) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _handleAsync(() async {
        _selectedAccount = await _accountService.getAccountById(id);
      });
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addAccount(Account account, File? image) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _handleAsync(() async {
        final newAccount = await _accountService.createAccount(account, image);
        _accounts.add(newAccount);
      });
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateAccount(Account account, File? image) async {
    if (account.id == null) {
      _error = 'Account ID is null';
      notifyListeners();
      throw Exception(_error);
    }

    _isLoading = true;
    notifyListeners();

    try {
      final updatedAccount = await _accountService.updateAccount(
        account.id!,
        account,
        image,
      );

      final index = _accounts.indexWhere((a) => a.id == updatedAccount.id);
      if (index != -1) {
        _accounts[index] = updatedAccount;
      }

      if (_selectedAccount?.id == updatedAccount.id) {
        _selectedAccount = updatedAccount;
      }

      _tempAvatar = null; // clear temporary avatar
      _error = null;
    } catch (e) {
      _error = 'Failed to update account: $e';
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteAccount(String id) async {
    final index = _accounts.indexWhere((a) => a.id == id);
    if (index == -1) return;

    final removedAccount = _accounts.removeAt(index);
    notifyListeners();

    try {
      await _handleAsync(() async {
        await _accountService.deleteAccount(id);
      });
    } catch (_) {
      _accounts.insert(index, removedAccount); // rollback
      notifyListeners();
      rethrow;
    }
  }

  Future<void> signIn(String accountId) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _handleAsync(() async {
        _selectedAccount = await _accountService.getAccountById(accountId);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_loggedInAccountKey, accountId);
      });
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final accountId = prefs.getString(_loggedInAccountKey);

    if (accountId != null) {
      await signIn(accountId);
    }
  }

  Future<void> signOut() async {
    _selectedAccount = null;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_loggedInAccountKey);
  }

  // Set temporary avatar locally, to show it before actual update
  void setTempAvatar(File image) {
    _tempAvatar = image;
    notifyListeners();
  }

  Future<void> updateAvatar(File image) async {
    if (_selectedAccount == null || _selectedAccount!.id == null) {
      _error = 'No selected account to update avatar';
      notifyListeners();
      throw Exception(_error);
    }

    await updateAccount(_selectedAccount!, image);
  }


//
// Not implemented on backend
//
// Future<void> loadAccountsByHomeId(String homeId) async {
//   _isLoading = true;
//   notifyListeners();
//
//   try {
//     await _handleAsync(() async {
//       _accounts = await _accountService.getAccountsByHomeId(homeId);
//     });
//   } finally {
//     _isLoading = false;
//     notifyListeners();
//   }
// }

}
