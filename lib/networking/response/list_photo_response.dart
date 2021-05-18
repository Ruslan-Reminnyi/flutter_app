import 'package:flutter_app/data/photo_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'list_photo_response.g.dart';

@JsonSerializable(createToJson: false)
class ListPhotoResponse {

  final int? id;
  final List<PhotoModel>? backdrops;
  final List<PhotoModel>? posters;

  ListPhotoResponse({this.id, this.backdrops, this.posters});

  factory ListPhotoResponse.fromJson(Map<String, dynamic> json) => _$ListPhotoResponseFromJson(json);

}
