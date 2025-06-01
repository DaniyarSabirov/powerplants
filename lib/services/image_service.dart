import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';

import 'api_client.dart';

class ImageService {
  final ApiClient _client;

  ImageService(this._client);

  Future<bool> uploadImage(String imageId, File imageFile) async {
    final bytes = await imageFile.readAsBytes();

    final response = await _client.put(
      '/images/$imageId',
      data: bytes,
      options: Options(
        headers: {'Content-Type': 'application/octet-stream'},
      ),
    );

    return response.statusCode == 200;
  }

  Future<Uint8List?> downloadImage(String imageId) async {
    final response = await _client.get(
      '/images/$imageId',
      options: Options(responseType: ResponseType.bytes),
    );

    if (response.statusCode == 200 && response.data is List<int>) {
      return Uint8List.fromList(response.data);
    } else {
      return null;
    }
  }
}
