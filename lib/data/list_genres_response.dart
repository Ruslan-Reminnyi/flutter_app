import 'package:flutter_app/data/movie_genres_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'list_genres_response.g.dart';

@JsonSerializable(createToJson: false)
class ListGenresResponse {
  final List<MovieGenresModel>? genres;

  ListGenresResponse({this.genres});

  factory ListGenresResponse.fromJson(Map<String, dynamic> json) =>
      _$ListGenresResponseFromJson(json);
}
