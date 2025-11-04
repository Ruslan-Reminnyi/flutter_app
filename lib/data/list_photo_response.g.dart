// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_photo_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListPhotoResponse _$ListPhotoResponseFromJson(Map<String, dynamic> json) {
  return ListPhotoResponse(
    id: json['id'] as int?,
    backdrops: (json['backdrops'] as List<dynamic>?)
        ?.map((e) => PhotoModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    posters: (json['posters'] as List<dynamic>?)
        ?.map((e) => PhotoModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}
