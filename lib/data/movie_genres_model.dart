import 'package:json_annotation/json_annotation.dart';

part 'movie_genres_model.g.dart';

@JsonSerializable(createToJson: false)
class MovieGenresModel {
  final int? id;
  final String? name;

  MovieGenresModel({this.id, this.name});

  factory MovieGenresModel.fromJson(Map<String, dynamic> json) =>
      _$MovieGenresModelFromJson(json);
}
