import 'package:json_annotation/json_annotation.dart';

part 'crew_model.g.dart';

@JsonSerializable(createToJson: false)
class CrewModel {
  final int? id;
  final String? name;
  final String? department;
  final String? job;

  CrewModel({
    this.id,
    this.name,
    this.department,
    this.job,
  });

  factory CrewModel.fromJson(Map<String, dynamic> json) =>
      _$CrewModelFromJson(json);
}
