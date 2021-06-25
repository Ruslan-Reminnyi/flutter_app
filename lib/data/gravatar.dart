import 'package:json_annotation/json_annotation.dart';

part 'gravatar.g.dart';

@JsonSerializable(createToJson: false)
class Gravatar {
  final String? hash;

  Gravatar({this.hash});

  factory Gravatar.fromJson(Map<String, dynamic> json) =>
      _$GravatarFromJson(json);
}
