// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieModel _$MovieModelFromJson(Map<String, dynamic> json) {
  return MovieModel(
    country: json['country'] as String?,
    rating: (json['vote_average'] as num?)?.toDouble(),
    genres:
        (json['genre_ids'] as List<dynamic>?)?.map((e) => e as int).toList(),
    run_time: json['run_time'] as int?,
    original_title: json['original_title'] as String?,
    original_name: json['original_name'] as String?,
    overview: json['overview'] as String?,
    poster_path: json['poster_path'] as String?,
    backdrop_path: json['backdrop_path'] as String?,
    id: json['id'] as int?,
  );
}
