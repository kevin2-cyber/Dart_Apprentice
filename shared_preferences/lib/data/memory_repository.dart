import 'dart:core';
import 'dart:async';
import 'repository.dart';
import 'models/models.dart';

class MemoryRepository extends Repository {

  final List<Recipe> _currentRecipes = <Recipe>[];
  final List<Ingredient> _currentIngredients = <Ingredient>[];
  Stream<List<Recipe>>? _recipeStream;
  Stream<List<Ingredient>>? _ingredientStream;
  final StreamController _recipeStreamController = StreamController<List<Recipe>>();
  final StreamController _ingredientStreamController = StreamController<List<Ingredient>>();

  // Add find methods
  @override
  Future<List<Recipe>> findAllRecipes() {
    return Future.value(_currentRecipes);
  }

  @override
  Future<Recipe> findRecipeById(int id) {
    return Future.value(_currentRecipes.firstWhere((recipe) => recipe.id == id));
  }

  @override
  Future<List<Ingredient>> findAllIngredients() {
    // 9
    return Future.value(_currentIngredients);
  }

  @override
  Future<List<Ingredient>> findRecipeIngredients(int recipeId) {
    // 10
    final recipe =
    _currentRecipes.firstWhere((recipe) => recipe.id == recipeId);
    // 11
    final recipeIngredients = _currentIngredients
        .where((ingredient) => ingredient.recipeId == recipe.id)
        .toList();
    return Future.value(recipeIngredients);
  }

  // Add insert methods
  @override
  Future<int> insertRecipe(Recipe recipe) {
    _currentRecipes.add(recipe);
    _recipeStreamController.sink.add(_currentRecipes);
    if (recipe.ingredients != null) {
      insertIngredients(recipe.ingredients!);
    }
    return Future.value(0);
  }

  @override
  Future<List<int>> insertIngredients(List<Ingredient> ingredients) {
    if (ingredients.isNotEmpty) {
      _currentIngredients.addAll(ingredients);
    }
    return Future.value(<int>[]);
  }

  // Add delete methods
  @override
  Future<void> deleteRecipe(Recipe recipe) async {
    _currentRecipes.remove(recipe);
    if (recipe.id != null) {
      deleteRecipeIngredients(recipe.id!);
    }
  }

  @override
  Future<void> deleteIngredient(Ingredient ingredient) async {
    _currentIngredients.remove(ingredient);
  }

  @override
  Future<void> deleteIngredients(List<Ingredient> ingredients) async {
    _currentIngredients
        .removeWhere((ingredient) =>
        ingredients.contains(ingredient));
  }

  @override
  Future<void> deleteRecipeIngredients(int recipeId) async {
    _currentIngredients
        .removeWhere((ingredient) => ingredient.recipeId == recipeId);
  }

  @override
  Stream<List<Recipe>> watchAllRecipes() {
    _recipeStream ??= _recipeStreamController.stream as Stream<List<Recipe>>;
    return _recipeStream!;
  }

  @override
  Stream<List<Ingredient>> watchAllIngredients() {
    _ingredientStream ??= _ingredientStreamController.stream as
      Stream<List<Ingredient>>;
    return _ingredientStream!;
  }

  @override
  Future init() {
    return Future.value();
  }

  @override
  void close() {
    _recipeStreamController.close();
    _ingredientStreamController.close();
  }

}