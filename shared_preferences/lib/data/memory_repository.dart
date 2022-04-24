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
  List<Recipe> findAllRecipes() {
    return _currentRecipes;
  }

  @override
  Recipe findRecipeById(int id) {
    return _currentRecipes.firstWhere((recipe) => recipe.id == id);
  }

  @override
  List<Ingredient> findAllIngredients() {
    // 9
    return _currentIngredients;
  }

  @override
  List<Ingredient> findRecipeIngredients(int recipeId) {
    // 10
    final recipe =
    _currentRecipes.firstWhere((recipe) => recipe.id == recipeId);
    // 11
    final recipeIngredients = _currentIngredients
        .where((ingredient) => ingredient.recipeId == recipe.id)
        .toList();
    return recipeIngredients;
  }

  // Add insert methods
  @override
  int insertRecipe(Recipe recipe) {
    _currentRecipes.add(recipe);
    if (recipe.ingredients != null) {
      insertIngredients(recipe.ingredients!);
    }
    notifyListeners();
    return 0;
  }

  @override
  List<int> insertIngredients(List<Ingredient> ingredients) {
    if (ingredients.length != 0) {
      _currentIngredients.addAll(ingredients);
      notifyListeners();
    }
    return <int>[];
  }

  // Add delete methods
  @override
  void deleteRecipe(Recipe recipe) {
    _currentRecipes.remove(recipe);
    if (recipe.id != null) {
      deleteRecipeIngredients(recipe.id!);
    }
    notifyListeners();
  }

  @override
  void deleteIngredient(Ingredient ingredient) {
    _currentIngredients.remove(ingredient);
  }

  @override
  void deleteIngredients(List<Ingredient> ingredients) {
    _currentIngredients
        .removeWhere((ingredient) =>
        ingredients.contains(ingredient));
    notifyListeners();
  }

  @override
  void deleteRecipeIngredients(int recipeId) {
    _currentIngredients
        .removeWhere((ingredient) => ingredient.recipeId ==
        recipeId);
    notifyListeners();
  }

  @override
  Stream<List<Recipe>> watchAllRecipes() {
    if(_recipeStream == null) {
      _recipeStream = _recipeStreamController.stream as Stream<List<Recipe>>;
    }
    return _recipeStream!;
  }

  @override
  Stream<List<Ingredient>> watchAllIngredients() {
    if (_ingredientStream == null) {
      _ingredientStream =
      _ingredientStreamController.stream as
      Stream<List<Ingredient>>;
    }
    return _ingredientStream!;
  }

  @override
  Future init() {
    return Future.value(null);
  }

  @override
  void close() {}

}