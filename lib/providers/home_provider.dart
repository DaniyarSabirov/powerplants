import 'package:flutter/cupertino.dart';
import 'package:frontend/models/home.dart';
import 'package:frontend/services/home_service.dart';

class HomeProvider extends ChangeNotifier {
  final HomeService _homeService;
  List<Home> _homes = [];
  bool _isLoading = false;
  String? _error;
  Home? _selectedHome;

  List<Home> get homes => _homes;
  bool get isLoading => _isLoading;
  String? get error => _error;
  Home? get selectedHome => _selectedHome;

  HomeProvider(this._homeService);

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

  Future<void> loadHomeById(String homeId) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _handleAsync(() async {
        _selectedHome = await _homeService.getHomeById(homeId);
      });
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadAllHomes() async {
    _isLoading = true;
    notifyListeners();

    try {
      await _handleAsync(() async {
        _homes = await _homeService.getAllHomes();
      });
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addHome(Home home) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _handleAsync(() async {
        final newHome = await _homeService.createHome(home);
        _homes.add(newHome);
      });
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateHome(Home home) async {
    await _handleAsync(() async {
      if (home.id == null) {
        _error = 'Home ID is null';
        notifyListeners();
        throw Exception(_error);
      }

      final index = _homes.indexWhere((h) => h.id == home.id);
      if (index == -1) {
        _error = 'Home with ID ${home.id} not found in local list';
        notifyListeners();
        throw Exception(_error);
      }

      await _homeService.updateHome(home.id!, home);
      _homes[index] = home;
      notifyListeners();
    });
  }

  Future<void> deleteHome(String homeId) async {
    final index = _homes.indexWhere((h) => h.id == homeId);
    if (index == -1) return;

    final removedHome = _homes.removeAt(index);
    notifyListeners();

    try {
      await _handleAsync(() async {
        await _homeService.deleteHome(homeId);
      });
    } catch (_) {
      _homes.insert(index, removedHome); // rollback on failure
      notifyListeners();
      rethrow;
    }
  }

  //
  // Not implemented on backend
  //
  // Future<void> loadHomesByAccountId(String accountId) async {
  //   _isLoading = true;
  //   notifyListeners();
  //
  //   try {
  //     await _handleAsync(() async {
  //       _homes = await _homeService.getHomesByAccountId(accountId);
  //     });
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }
}
