// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListResponse _$ListResponseFromJson(Map<String, dynamic> json) {
  return ListResponse(
    page: json['page'] as int?,
    totalResults: json['total_results'] as int?,
    totalPages: json['total_pages'] as int?,
    movies: (json['results'] as List<dynamic>?)
        ?.map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}
