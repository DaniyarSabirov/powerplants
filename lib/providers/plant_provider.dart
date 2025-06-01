import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:frontend/models/plant.dart';
import 'package:frontend/services/plant_service.dart';


class PlantProvider extends ChangeNotifier {
  final PlantService _plantService;
  List<Plant> _plants = [];
  bool _isLoading = false;
  String? _error;
  Plant? _selectedPlant;

  // Temporary local image file (for quick update before upload)
  File? _tempImage;

  List<Plant> get plants => _plants;
  bool get isLoading => _isLoading;
  String? get error => _error;
  Plant? get selectedPlant => _selectedPlant;
  File? get tempImage => _tempImage;

  PlantProvider(this._plantService);

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

  Future<void> loadPlantById(String groupId, String plantId) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _handleAsync(() async {
        _selectedPlant = await _plantService.getPlantById(groupId, plantId);
      });
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadPlantsForGroup(String groupId) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _handleAsync(() async {
        _plants = await _plantService.getPlantsByGroupId(groupId);
      });
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addPlant(Plant plant, File? image) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _handleAsync(() async {
        final newPlant = await _plantService.createPlant(plant, image);
        _plants.add(newPlant);
      });
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updatePlant(Plant plant, File? image) async {
    if (plant.id == null) {
      _error = 'Plant ID is null';
      notifyListeners();
      throw Exception(_error);
    }

    if (plant.groupId == null) {
      _error = 'Group ID is null';
      notifyListeners();
      throw Exception(_error);
    }

    _isLoading = true;
    notifyListeners();

    try {
      final index = _plants.indexWhere((p) => p.id == plant.id);
      if (index == -1) {
        _error = 'Plant with ID ${plant.id} not found';
        notifyListeners();
        throw Exception(_error);
      }

      final updatedPlant = await _plantService.updatePlant(plant.groupId!, plant.id!, plant, image);

      _plants[index] = updatedPlant;

      if (_selectedPlant?.id == updatedPlant.id) {
        _selectedPlant = updatedPlant;
      }

      if (image != null) {
        _tempImage = null;
      }

      _error = null;
    } catch (e) {
      _error = 'Failed to update plant: $e';
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deletePlant(String groupId, String plantId) async {
    final index = _plants.indexWhere((p) => p.id == plantId);
    if (index == -1) return;

    final removedPlant = _plants.removeAt(index);
    notifyListeners();

    try {
      await _handleAsync(() async {
        await _plantService.deletePlant(groupId, plantId);
      });
    } catch (_) {
      _plants.insert(index, removedPlant); // rollback changes
      notifyListeners();
      rethrow; // propagate error to _handleAsync
    }
  }

  void setTempImage(File image) {
    _tempImage = image;
    notifyListeners();
  }

  Future<void> updateImage(File image) async {
    if (_selectedPlant == null || _selectedPlant!.id == null) {
      _error = 'No selected plant to update image';
      notifyListeners();
      throw Exception(_error);
    }

    _isLoading = true;
    notifyListeners();

    try {
      final updatedPlant = await _plantService.updatePlant(
        _selectedPlant!.groupId,
        _selectedPlant!.id!,
        _selectedPlant!,
        image,
      );

      final index = _plants.indexWhere((p) => p.id == updatedPlant.id);
      if (index != -1) {
        _plants[index] = updatedPlant;
      }

      _selectedPlant = updatedPlant;
      _tempImage = null;
      _error = null;
    } catch (e) {
      _error = 'Failed to update image: $e';
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}