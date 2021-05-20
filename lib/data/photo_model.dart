import 'package:json_annotation/json_annotation.dart';

part 'photo_model.g.dart';

@JsonSerializable(createToJson: false)
class PhotoModel {
  final int? id;
  @JsonKey(name: 'file_path')
  final String? path;

  PhotoModel({this.id, this.path});

  factory PhotoModel.fromJson(Map<String, dynamic> json) =>
      _$PhotoModelFromJson(json);
}
