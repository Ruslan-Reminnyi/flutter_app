import 'package:json_annotation/json_annotation.dart';

part 'movie_details_model.g.dart';

@JsonSerializable(createToJson: false)
class MovieDetailsModel {

  final String? tagline;
  final String? imdb_id;
  final int? id;

  MovieDetailsModel(
      {this.tagline,
        this.imdb_id,
        this.id});

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) => _$MovieDetailsModelFromJson(json);

}
