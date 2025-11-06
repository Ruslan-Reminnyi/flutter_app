import 'package:json_annotation/json_annotation.dart';

part 'movie_model.g.dart';

@JsonSerializable(createToJson: false)
class MovieModel {
  @JsonKey(name: 'vote_average')
  final double? rating;
  @JsonKey(name: 'genre_ids')
  final List<int>? genres;
  @JsonKey(name: 'original_title')
  final String? originalTitle;
  @JsonKey(name: 'original_name')
  final String? originalName;
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;
  final int? id;

  MovieModel({
    this.rating,
    this.genres,
    this.originalTitle,
    this.originalName,
    this.posterPath,
    this.backdropPath,
    this.id,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);
}
