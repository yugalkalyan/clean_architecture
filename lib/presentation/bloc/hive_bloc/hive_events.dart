part of 'hive_bloc.dart';

abstract class HiveStorageEvents{
  const HiveStorageEvents();
}

class InitialiseHiveStorageEvent extends HiveStorageEvents{
  const InitialiseHiveStorageEvent();
}

class AddDataToHiveListEvent extends HiveStorageEvents{
  const AddDataToHiveListEvent({required this.photoData});
final PhotoModel photoData;
}