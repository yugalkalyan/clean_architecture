import 'dart:io';


import 'package:clean_architecture/presentation/bloc/hive_bloc/hive_bloc.dart';
import 'package:clean_architecture/presentation/bloc/photo_bloc/photo_bloc.dart';
import 'package:clean_architecture/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'core/network/network_client.dart';
import 'data/datasources/remote_data_source.dart';
import 'data/models/photo_model.dart';
import 'data/repositories/photo_repository_impl.dart';
import 'domain/usecases/get_photos.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final path = Platform.isAndroid
      ? await getExternalStorageDirectory()
      : await getApplicationSupportDirectory();
  Hive..init(path!.path)
  ..registerAdapter(PhotoModelAdapter());
  final NetworkClient networkClient = NetworkClient();
  final RemoteDataSource remoteDataSource = RemoteDataSource(client: networkClient);
  final PhotoRepositoryImpl photoRepository = PhotoRepositoryImpl(remoteDataSource: remoteDataSource);
  final GetPhotos getPhotos = GetPhotos(repository: photoRepository);

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
          providers: [
            BlocProvider<HiveStorageBloc>(create: (_) => HiveStorageBloc()..add(const InitialiseHiveStorageEvent(),),lazy: false,),
            BlocProvider<PhotoBloc>(create: (_) => PhotoBloc(getPhotos: getPhotos)..add( FetchPhotos())),
          ],
        child: HomePage(),
      ),
    ),
  );
}