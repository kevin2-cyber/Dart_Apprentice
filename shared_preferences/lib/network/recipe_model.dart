import 'package:json_annotation/json_annotation.dart';

part 'recipe_model.g.dart';

@JsonSerializable()
class APIRecipeQuery {
  //Add APIRecipeQuery.fromJson
  factory APIRecipeQuery.fromJson(Map<String, dynamic> json) => _$APIRecipeQueryFromJson(json);
  Map<String, dynamic> toJson() => _$APIRecipeQueryToJson(this);
  @JsonKey(name: 'q')
  String query;
  int from;
  int to;
  bool more;
  int counts;
  List<APIHits> hits;

  APIRecipeQuery({
    required this.query,
    required this.from,
    required this.to,
    required this.more,
    required this.counts,
    required this.hits,
});
}
//Add @JsonSerializable() class APIHits
class APIHits {
  APIRecipe recipe;

  APIHits({
    required this.recipe,
});
  factory APIHits.fromJson(Map<String, dynamic> json) => _$APIHitsFromJson(json);
  Map<String, dynamic> toJson() => _$APIHitsToJson(this);
}
//TODO: Add @JsonSerializable() class APIRecipe
//TODO: Add @JsonSerializable() class APIIngredients