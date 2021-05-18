import 'package:flutter_app/data/product_companies_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie_details_response.g.dart';

@JsonSerializable(createToJson: false)
class MovieDetailsResponse {

  final String? tagline;
  final int? runtime;
  final List<ProductionCompaniesModel>? production_companies;
  final String? imdb_id;
  final int? id;

  MovieDetailsResponse(
      {this.tagline,
        this.runtime,
        this.production_companies,
        this.imdb_id,
        this.id});

  factory MovieDetailsResponse.fromJson(Map<String, dynamic> json) => _$MovieDetailsResponseFromJson(json);

}
