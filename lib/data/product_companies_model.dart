import 'package:json_annotation/json_annotation.dart';

part 'product_companies_model.g.dart';

@JsonSerializable(createToJson: false)
class ProductionCompaniesModel {
  @JsonKey(name: 'logo_path')
  final String? logoPath;
  final int? id;

  ProductionCompaniesModel({this.logoPath, this.id});

  factory ProductionCompaniesModel.fromJson(Map<String, dynamic> json) =>
      _$ProductionCompaniesModelFromJson(json);
}
