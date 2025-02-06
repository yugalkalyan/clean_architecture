import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/photo_model.dart';
import '../../../domain/usecases/get_photos.dart';


part 'photo_event.dart';
part 'photo_state.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  final GetPhotos getPhotos;

  PhotoBloc({required this.getPhotos}) : super(PhotoInitial()) {
    on<FetchPhotos>(_onFetchPhotos);
  }

  void _onFetchPhotos(FetchPhotos event, Emitter<PhotoState> emit) async {
    emit(PhotoLoading());
    try {
      final result = await getPhotos.call();
      emit(PhotoLoaded(photos: result));
    } catch (e,s) {
      debugPrint(s.toString());
      emit(PhotoError(message: e.toString()));
    }
  }
}