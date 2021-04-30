import 'package:json_annotation/json_annotation.dart';

part 'movie_model.g.dart';

@JsonSerializable(createToJson: false)
class MovieModel {

  final String? country;
  @JsonKey(name: 'vote_average')
  final double? rating;
  @JsonKey(name: 'genre_ids')
  final List<int>? genres;
  final int? run_time;
  final String? original_title;
  final String? original_name;
  final String? overview;
  final String? poster_path;
  final String? backdrop_path;
  final int? id;

  MovieModel(
      {this.country,
        this.rating,
        this.genres,
        this.run_time,
        this.original_title,
        this.original_name,
        this.overview,
        this.poster_path,
        this.backdrop_path,
        this.id});

  factory MovieModel.fromJson(Map<String, dynamic> json) => _$MovieModelFromJson(json);

}
