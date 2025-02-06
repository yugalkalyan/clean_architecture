import '../../data/models/photo_model.dart';
import '../repositories/photo_repository.dart';

class GetPhotos {
  final PhotoRepository repository;

  GetPhotos({required this.repository});

  Future<List<PhotoModel>> call() async {
    return await repository.getPhotos();
  }
}