import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:frontend/models/home_group.dart';
import 'package:frontend/services/home_group_service.dart';

class HomeGroupProvider extends ChangeNotifier {
  final HomeGroupService _homeGroupService;
  List<HomeGroup> _groups = [];
  bool _isLoading = false;
  String? _error;
  HomeGroup? _selectedGroup;

  // Temporary local image file (for quick update before upload)
  File? _tempImage;

  List<HomeGroup> get groups => _groups;
  bool get isLoading => _isLoading;
  String? get error => _error;
  HomeGroup? get selectedGroup => _selectedGroup;
  File? get tempImage => _tempImage;

  HomeGroupProvider(this._homeGroupService);

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

  Future<void> loadGroupsByHomeId(String homeId) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _handleAsync(() async {
        _groups = await _homeGroupService.getGroupsByHomeId(homeId);
      });
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addGroup(HomeGroup group, File? image) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _handleAsync(() async {
        final newGroup = await _homeGroupService.createGroup(group.homeId, group, image);
        _groups.add(newGroup);
      });
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateGroup(HomeGroup group, File? image) async {
    await _handleAsync(() async {
      if (group.id == null) {
        _error = 'Group ID is null';
        notifyListeners();
        throw Exception(_error);
      }

      final index = _groups.indexWhere((g) => g.id == group.id);
      if (index == -1) {
        _error = 'Group with ID ${group.id} not found in local list';
        notifyListeners();
        throw Exception(_error);
      }

      final updatedGroup = await _homeGroupService.updateGroup(
        group.homeId,
        group.id!,
        group,
        image,
      );

      _groups[index] = updatedGroup;

      if (_selectedGroup?.id == updatedGroup.id) {
        _selectedGroup = updatedGroup;
      }

      _tempImage = null;
      notifyListeners();
    });
  }

  Future<void> deleteGroup(String homeId, String groupId) async {
    final index = _groups.indexWhere((g) => g.id == groupId);
    if (index == -1) return;

    final removedGroup = _groups.removeAt(index);
    notifyListeners();

    try {
      await _handleAsync(() async {
        await _homeGroupService.deleteGroup(homeId, groupId);
      });
    } catch (_) {
      _groups.insert(index, removedGroup); // rollback
      notifyListeners();
      rethrow;
    }
  }

  void setTempImage(File image) {
    _tempImage = image;
    notifyListeners();
  }

//
//  Method on backend is not implemented
//
// Future<void> loadGroupById(String groupId) async {
//   _isLoading = true;
//   notifyListeners();
//
//   try {
//     await _handleAsync(() async {
//       _selectedGroup = await _homeGroupService.getGroupById(groupId);
//     });
//   } finally {
//     _isLoading = false;
//     notifyListeners();
//   }
// }
}
