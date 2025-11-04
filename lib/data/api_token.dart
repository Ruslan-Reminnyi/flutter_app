import 'package:json_annotation/json_annotation.dart';

part 'api_token.g.dart';

@JsonSerializable()
class ApiToken {
  @JsonKey(name: 'request_token')
  final String token;

  ApiToken({required this.token});

  factory ApiToken.fromJson(Map<String, dynamic> json) =>
      _$ApiTokenFromJson(json);

  Map<String, dynamic> toJson() => _$ApiTokenToJson(this);
}
