
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../../../data/models/photo_model.dart';



part 'hive_state.dart';
part 'hive_events.dart';


class HiveStorageBloc extends Bloc<HiveStorageEvents,HiveStorageState>{
  HiveStorageBloc():super(const HiveStorageState()){
    on<InitialiseHiveStorageEvent>(_initialiseHive);
    on<AddDataToHiveListEvent>(_addToHive);
  }
  late Box<PhotoModel> photosBox;
   List<PhotoModel> data=[];
  Future<void>_initialiseHive(InitialiseHiveStorageEvent event,Emitter<HiveStorageState>emit)async{
    photosBox = await Hive.openBox<PhotoModel>('photosData');
      data=photosBox.values.toList();

    emit(state.copyWith(hiveStorageStatus:HiveStorageStatus.success, photosList:data));
  }

  Future<void>_addToHive(AddDataToHiveListEvent event,Emitter<HiveStorageState>emit)async{
    List<PhotoModel> photosList=state.photosList;
  if(!photosList.contains(event.photoData)){
    photosList.add(event.photoData);
    photosBox.add(event.photoData);
  }else{
    int index = photosList.indexOf(event.photoData);
    if (index != -1) {
      photosList.removeAt(index);
     await photosBox.deleteAt(index);
    }
  }
    emit(state.copyWith(hiveStorageStatus:HiveStorageStatus.success, photosList:photosList));
  }
}