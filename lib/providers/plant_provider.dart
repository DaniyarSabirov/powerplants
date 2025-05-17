import 'package:flutter/cupertino.dart';
import 'package:frontend/models/plant.dart';
import 'package:frontend/services/plant_service.dart';


class PlantProvider extends ChangeNotifier {
  final PlantService _plantService;
  List<Plant> _plants = [];
  bool _isLoading = false;
  String? _error;
  Plant? _selectedPlant;

  List<Plant> get plants => _plants;
  bool get isLoading => _isLoading;
  String? get error => _error;
  Plant? get selectedPlant => _selectedPlant;

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

  Future<void> addPlant(Plant plant) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _handleAsync(() async {
        final newPlant = await _plantService.createPlant(plant);
        _plants.add(newPlant);
      });
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updatePlant(Plant plant) async {
    await _handleAsync(() async {
      final index = _plants.indexWhere((p) => p.id == plant.id);
      if (index == -1) {
        _error = 'Plant with ID ${plant.id} not found in local list';
        notifyListeners();
        throw Exception(_error);
      }

      if (plant.id == null) {
        _error = 'PlantID is null';
        notifyListeners();
        throw Exception(_error);
      }

      final oldPlant = _plants[index];
      final groupId = oldPlant.groupId;
      final plantId = plant.id!;

      await _plantService.updatePlant(groupId, plantId, plant);
      _plants[index] = plant;
      notifyListeners();
    });
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

}