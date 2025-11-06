// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieDetailsResponse _$MovieDetailsResponseFromJson(
  Map<String, dynamic> json,
) => MovieDetailsResponse(
  photoResponse: json['images'] == null
      ? null
      : ListPhotoResponse.fromJson(json['images'] as Map<String, dynamic>),
  creditsResponse: json['credits'] == null
      ? null
      : CreditsResponse.fromJson(json['credits'] as Map<String, dynamic>),
  listSimilarMovies: json['similar'] == null
      ? null
      : ListResponse.fromJson(json['similar'] as Map<String, dynamic>),
  rating: (json['vote_average'] as num?)?.toDouble(),
  genres: (json['genres'] as List<dynamic>?)
      ?.map((e) => MovieGenresModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  originalTitle: json['original_title'] as String?,
  overview: json['overview'] as String?,
  posterPath: json['poster_path'] as String?,
  backdropPath: json['backdrop_path'] as String?,
  tagline: json['tagline'] as String?,
  runtime: (json['runtime'] as num?)?.toInt(),
  productionCompanies: (json['production_companies'] as List<dynamic>?)
      ?.map((e) => ProductionCompaniesModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  id: (json['id'] as num?)?.toInt(),
);
