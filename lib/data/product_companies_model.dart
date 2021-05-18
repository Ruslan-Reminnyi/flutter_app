import 'package:json_annotation/json_annotation.dart';

part 'product_companies_model.g.dart';

@JsonSerializable(createToJson: false)
class ProductionCompaniesModel {

  final String? logo_path;
  final int? id;

  ProductionCompaniesModel(
      {this.logo_path,
        this.id});

  factory ProductionCompaniesModel.fromJson(Map<String, dynamic> json) => _$ProductionCompaniesModelFromJson(json);

}
