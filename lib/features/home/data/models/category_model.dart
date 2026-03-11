import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/category.dart';

part 'category_model.freezed.dart';
part 'category_model.g.dart';

@freezed
abstract class CategoryModel with _$CategoryModel {
  const CategoryModel._();

  const factory CategoryModel({
    required String id,
    required String name,
    @JsonKey(name: 'icon_url') String? iconUrl,
    String? slug,
  }) = _CategoryModel;

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Category toEntity() =>
      Category(id: id, name: name, iconUrl: iconUrl, slug: slug);
}
