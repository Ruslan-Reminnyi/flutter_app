// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_photo_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListPhotoResponse _$ListPhotoResponseFromJson(Map<String, dynamic> json) =>
    ListPhotoResponse(
      id: (json['id'] as num?)?.toInt(),
      backdrops: (json['backdrops'] as List<dynamic>?)
          ?.map((e) => PhotoModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      posters: (json['posters'] as List<dynamic>?)
          ?.map((e) => PhotoModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
