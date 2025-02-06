import '../../data/models/photo_model.dart';

abstract class PhotoRepository {
  Future<List<PhotoModel>> getPhotos();
}