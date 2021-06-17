import 'package:json_annotation/json_annotation.dart';

part 'session_id.g.dart';

@JsonSerializable()
class SessionId {
  @JsonKey(name: 'session_id')
  final String? id;

  SessionId({this.id});

  factory SessionId.fromJson(Map<String, dynamic> json) =>
      _$SessionIdFromJson(json);

  Map<String, dynamic> toJson() => _$SessionIdToJson(this);
}
