// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieDetailsResponse _$MovieDetailsResponseFromJson(Map<String, dynamic> json) {
  return MovieDetailsResponse(
    tagline: json['tagline'] as String?,
    runtime: json['runtime'] as int?,
    production_companies: (json['production_companies'] as List<dynamic>?)
        ?.map(
            (e) => ProductionCompaniesModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    imdb_id: json['imdb_id'] as String?,
    id: json['id'] as int?,
  );
}
