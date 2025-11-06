// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountModel _$AccountModelFromJson(Map<String, dynamic> json) => AccountModel(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  avatar: json['avatar'] == null
      ? null
      : Avatar.fromJson(json['avatar'] as Map<String, dynamic>),
);
