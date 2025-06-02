import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:frontend/services/image_service.dart';

class ImageProvider with ChangeNotifier {
  final ImageService _imageService;

  Uint8List? _imageBytes;
  bool _isLoading = false;
  bool _isUploading = false;
  String? _errorMessage;

  ImageProvider(this._imageService);

  Uint8List? get imageBytes => _imageBytes;
  bool get isLoading => _isLoading;
  bool get isUploading => _isUploading;
  String? get errorMessage => _errorMessage;

  Future<void> loadImage(String imageId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final bytes = await _imageService.downloadImage(imageId);
      if (bytes != null) {
        _imageBytes = bytes;
        _errorMessage = null;
      } else {
        _errorMessage = 'Failed to download image (status ≠ 200)';
        _imageBytes = null;
      }
    } catch (e) {
      _errorMessage = e.toString();
      _imageBytes = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  Future<void> uploadImage(String imageId, File file) async {
    _isUploading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final success = await _imageService.uploadImage(imageId, file);
      if (success) {
        try {
          final bytes = await _imageService.downloadImage(imageId);
          if (bytes != null) {
            _imageBytes = bytes;
            _errorMessage = null;
          } else {
            _errorMessage = 'Upload succeeded, but failed to fetch updated image';
          }
        } catch (e) {
          _errorMessage = 'Failed to fetch updated image: ${e.toString()}';
        }
      } else {
        _errorMessage = 'Failed to upload image (status ≠ 200)';
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isUploading = false;
      notifyListeners();
    }
  }


  void clear() {
    _imageBytes = null;
    _errorMessage = null;
    notifyListeners();
  }
}
