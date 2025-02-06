part of 'hive_bloc.dart';

enum HiveStorageStatus{
  initial,
  loading,
  success,
  failure,
}

class HiveStorageState{
  const HiveStorageState({this.hiveStorageStatus=HiveStorageStatus.initial,this.photosList=const<PhotoModel>[]});
  final HiveStorageStatus hiveStorageStatus;
  final List<PhotoModel> photosList;

  HiveStorageState copyWith(
  {HiveStorageStatus? hiveStorageStatus,
    List<PhotoModel>? photosList}
  ){
    return HiveStorageState(
      hiveStorageStatus: hiveStorageStatus??this.hiveStorageStatus,
        photosList: photosList??this.photosList
    );
  }

}