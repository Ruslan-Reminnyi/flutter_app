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
    originalTitle: json['original_title'] as String?,
    originalName: json['original_name'] as String?,
    overview: json['overview'] as String?,
    posterPath: json['poster_path'] as String?,
    backdropPath: json['backdrop_path'] as String?,
    id: json['id'] as int?,
  );
}
