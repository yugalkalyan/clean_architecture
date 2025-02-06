
import 'dart:convert';

import '../../core/network/network_client.dart';
import '../models/photo_model.dart';

class RemoteDataSource {
  final NetworkClient client;

  RemoteDataSource({required this.client});

  Future<List<PhotoModel>> getPhotos() async {
    final response = await client.get();
    if (response.statusCode == 200) {
      var data =json.decode(response.body);
      final List<dynamic> list = data["data"];
      return list.map((json) => PhotoModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load photos');
    }
  }
}