import 'package:hive/hive.dart';

part 'photo_model.g.dart';

@HiveType(typeId: 0)
class PhotoModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String thumbnailUrl;

  PhotoModel({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
  });

  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel(
      id: json['id'],
      title: json['first_name'],
      thumbnailUrl: json['avatar'],
    );
  }

  PhotoModel toEntity() {
    return PhotoModel(
      id: id,
      title: title,
      thumbnailUrl: thumbnailUrl,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PhotoModel &&
        other.id == id &&
        other.title == title &&
        other.thumbnailUrl == thumbnailUrl;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ thumbnailUrl.hashCode;
}
