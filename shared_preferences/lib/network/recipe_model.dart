import 'package:json_annotation/json_annotation.dart';

part 'recipe_model.g.dart';

@JsonSerializable()
class APIRecipeQuery {
  //TODO: Add APIRecipeQuery.fromJson
  factory APIRecipeQuery.fromJson(Map<String, dynamic> json) => _$APIRecipeQueryFromJson(json);
  Map<String, dynamic> toJson() => _$APIRecipeQueryToJson(this);
}
//TODO: Add @JsonSerializable() class APIHits
//TODO: Add @JsonSerializable() class APIRecipe
//TODO: Add @JsonSerializable() class APIIngredients