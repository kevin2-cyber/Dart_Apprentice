import 'models/models.dart';

abstract class Repository {

  // Add find methods
  Future<List<Recipe>> findAllRecipes();
  // Add watch methods
  Stream<List<Recipe>> watchAllRecipes();
  Stream<List<Ingredient>> watchAllIngredients();

  Future<Recipe> findRecipeById(int id);
  Future<List<Ingredient>> findAllIngredients();
  Future<List<Ingredient>> findRecipeIngredients(int recipeId);

  // Add insert methods
  Future<int> insertRecipe(Recipe recipe);
  Future<List<int>> insertIngredients(List<Ingredient> ingredients);

  // Add delete methods
  Future<void> deleteRecipe(Recipe recipe);
  Future<void> deleteIngredient(Ingredient ingredient);
  Future<void> deleteIngredients(List<Ingredient> ingredients);
  Future<void> deleteRecipeIngredients(int recipeId);

  // Add initializing and closing methods
  Future init();
  void close();
}