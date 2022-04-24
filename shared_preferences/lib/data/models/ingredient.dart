import 'package:equatable/equatable.dart';

class Ingredient extends Equatable {
  int? id;
  int? recipeId;
  final String? name;
  final double? weight;

  Ingredient({this.id, this.recipeId, this.name, this.weight});

  @override
  // TODO: implement props
  List<Object?> get props => [recipeId, name, weight];

  // Create a Ingredient from JSON data
  factory Ingredient.fromJson(Map<String, dynamic> json) => Ingredient(
    id: json['ingredientId'],
    recipeId: json['recipeId'],
    name: json['name'],
    weight: json['weight'],
  );

}