// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListResponse _$ListResponseFromJson(Map<String, dynamic> json) => ListResponse(
  page: (json['page'] as num?)?.toInt(),
  totalResults: (json['total_results'] as num?)?.toInt(),
  totalPages: (json['total_pages'] as num?)?.toInt(),
  movies: (json['results'] as List<dynamic>?)
      ?.map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);
