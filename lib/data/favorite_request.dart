import 'package:json_annotation/json_annotation.dart';

part 'favorite_request.g.dart';

@JsonSerializable()
class FavoriteRequest {
  @JsonKey(name: 'media_type')
  final String mediaType;
  @JsonKey(name: 'media_id')
  final int mediaId;
  @JsonKey(name: 'favorite')
  final bool favorite;

  FavoriteRequest(
      {required this.mediaType, this.mediaId = 0, required this.favorite});

  factory FavoriteRequest.fromJson(Map<String, dynamic> json) =>
      _$FavoriteRequestFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteRequestToJson(this);
}
