// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credits_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreditsResponse _$CreditsResponseFromJson(Map<String, dynamic> json) {
  return CreditsResponse(
    id: json['id'] as int?,
    cast: (json['cast'] as List<dynamic>?)
        ?.map((e) => CastModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    crew: (json['crew'] as List<dynamic>?)
        ?.map((e) => CrewModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}
