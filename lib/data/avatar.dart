import 'package:flutter_app/data/gravatar.dart';
import 'package:json_annotation/json_annotation.dart';

part 'avatar.g.dart';

@JsonSerializable(createToJson: false)
class Avatar {
  final Gravatar? gravatar;

  Avatar({this.gravatar});

  factory Avatar.fromJson(Map<String, dynamic> json) => _$AvatarFromJson(json);
}
