import 'package:json_annotation/json_annotation.dart';

part 'favorite_request.g.dart';

@JsonSerializable()
class FavoriteRequest {
  @JsonKey(name: 'media_type')
  final String mediaType;
  @JsonKey(name: 'media_id')
  final int mediaId;
  final bool favorite;

  FavoriteRequest({
    this.mediaType = "movie",
    this.mediaId = 0,
    this.favorite = false,
  });

  factory FavoriteRequest.fromJson(Map<String, dynamic> json) =>
      _$FavoriteRequestFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteRequestToJson(this);
}
