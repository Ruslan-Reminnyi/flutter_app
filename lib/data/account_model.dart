import 'package:flutter_app/data/avatar.dart';
import 'package:flutter_app/data/gravatar.dart';
import 'package:json_annotation/json_annotation.dart';

part 'account_model.g.dart';

@JsonSerializable(createToJson: false)
class AccountModel {
  final int? id;
  final String? name;
  final Avatar? avatar;

  AccountModel({this.id, this.name, this.avatar});

  factory AccountModel.fromJson(Map<String, dynamic> json) =>
      _$AccountModelFromJson(json);
}
