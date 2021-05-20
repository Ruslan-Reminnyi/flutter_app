import 'package:json_annotation/json_annotation.dart';

part 'cast_model.g.dart';

@JsonSerializable(createToJson: false)
class CastModel {
  final int? id;
  @JsonKey(name: 'profile_path')
  final String? path;

  CastModel({this.id, this.path});

  factory CastModel.fromJson(Map<String, dynamic> json) =>
      _$CastModelFromJson(json);
}
