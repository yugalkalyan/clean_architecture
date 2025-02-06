import '../../domain/repositories/photo_repository.dart';
import '../datasources/remote_data_source.dart';
import '../models/photo_model.dart';

class PhotoRepositoryImpl implements PhotoRepository {
  final RemoteDataSource remoteDataSource;

  PhotoRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<PhotoModel>> getPhotos() async {
    final photoModels = await remoteDataSource.getPhotos();
    return photoModels.map((model) => model.toEntity()).toList();
  }
}