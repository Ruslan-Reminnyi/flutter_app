// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteRequest _$FavoriteRequestFromJson(Map<String, dynamic> json) {
  return FavoriteRequest(
    mediaType: json['media_type'] as String,
    mediaId: json['media_id'] as int,
    favorite: json['favorite'] as bool,
  );
}

Map<String, dynamic> _$FavoriteRequestToJson(FavoriteRequest instance) =>
    <String, dynamic>{
      'media_type': instance.mediaType,
      'media_id': instance.mediaId,
      'favorite': instance.favorite,
    };
