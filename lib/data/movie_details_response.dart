import 'package:flutter_app/data/movie_genres_model.dart';
import 'package:flutter_app/data/product_companies_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie_details_response.g.dart';

@JsonSerializable(createToJson: false)
class MovieDetailsResponse {
  final String? country;
  @JsonKey(name: 'vote_average')
  final double? rating;
  final List<MovieGenresModel>? genres;
  @JsonKey(name: 'original_title')
  final String? originalTitle;
  final String? overview;
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;
  final String? tagline;
  final int? runtime;
  @JsonKey(name: 'production_companies')
  final List<ProductionCompaniesModel>? productionCompanies;
  final int? id;

  MovieDetailsResponse(
      {this.country,
      this.rating,
      this.genres,
      this.originalTitle,
      this.overview,
      this.posterPath,
      this.backdropPath,
      this.tagline,
      this.runtime,
      this.productionCompanies,
      this.id});

  factory MovieDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailsResponseFromJson(json);
}
