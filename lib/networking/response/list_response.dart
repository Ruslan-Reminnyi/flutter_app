import 'package:flutter_app/data/movie_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'list_response.g.dart';

@JsonSerializable(createToJson: false)
class ListResponse {

  final int? page;
  @JsonKey(name: 'total_results')
  final int? totalResults;
  @JsonKey(name: 'total_pages')
  final int? totalPages;
  @JsonKey(name: "results")
  final List<MovieModel>? movies;

  ListResponse({this.page, this.totalResults, this.totalPages, this.movies});

  factory ListResponse.fromJson(Map<String, dynamic> json) => _$ListResponseFromJson(json);

}
