import 'package:flutter/cupertino.dart';
import 'package:frontend/models/account.dart';
import 'package:frontend/services/account_service.dart';

class AccountProvider extends ChangeNotifier {
  final AccountService _accountService;
  List<Account> _accounts = [];
  bool _isLoading = false;
  String? _error;
  Account? _selectedAccount;

  List<Account> get accounts => _accounts;
  bool get isLoading => _isLoading;
  String? get error => _error;
  Account? get selectedAccount => _selectedAccount;

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

  Future<void> loadAccountsByHomeId(String homeId) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _handleAsync(() async {
        _accounts = await _accountService.getAccountsByHomeId(homeId);
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

  Future<void> addAccount(Account account) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _handleAsync(() async {
        final newAccount = await _accountService.createAccount(account);
        _accounts.add(newAccount);
      });
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateAccount(Account account) async {
    await _handleAsync(() async {
      final index = _accounts.indexWhere((a) => a.id == account.id);
      if (index == -1) {
        _error = 'Account with ID ${account.id} not found in local list';
        notifyListeners();
        throw Exception(_error);
      }

      if (account.id == null) {
        _error = 'Account ID is null';
        notifyListeners();
        throw Exception(_error);
      }

      await _accountService.updateAccount(account.id!, account);
      _accounts[index] = account;
      notifyListeners();
    });
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
}
