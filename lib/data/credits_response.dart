import 'package:flutter_app/data/cast_model.dart';
import 'package:flutter_app/data/crew_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'credits_response.g.dart';

@JsonSerializable(createToJson: false)
class CreditsResponse {
  final int? id;
  final List<CastModel>? cast;
  final List<CrewModel>? crew;

  CreditsResponse({this.id, this.cast, this.crew});

  factory CreditsResponse.fromJson(Map<String, dynamic> json) =>
      _$CreditsResponseFromJson(json);
}
