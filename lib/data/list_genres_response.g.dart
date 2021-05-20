// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_genres_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListGenresResponse _$ListGenresResponseFromJson(Map<String, dynamic> json) {
  return ListGenresResponse(
    genres: (json['genres'] as List<dynamic>?)
        ?.map((e) => MovieGenresModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}
