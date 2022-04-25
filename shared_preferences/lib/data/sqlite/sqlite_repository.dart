import 'dart:async';
// 1
import '../repository.dart';
import 'database_helper.dart';
import '../models/models.dart';
// 2
class SqliteRepository extends Repository {
  // 3
  final dbHelper = DatabaseHelper.instance;
  // Add methods to use dbHelper here
  @override
  Future<List<Recipe>> findAllRecipes() {
    return dbHelper.findAllRecipes();
  }
  @override
  Stream<List<Recipe>> watchAllRecipes() {
    return dbHelper.watchAllRecipes();
  }
  @override
  Stream<List<Ingredient>> watchAllIngredients() {
    return dbHelper.watchAllIngredients();
  }
  @override
  Future<Recipe> findRecipeById(int id) {
    return dbHelper.findRecipeById(id);
  }
  @override
  Future<List<Ingredient>> findAllIngredients() {
    return dbHelper.findAllIngredients();
  }
  @override
  Future<List<Ingredient>> findRecipeIngredients(int id) {
    return dbHelper.findRecipeIngredients(id);
  }

  // Add recipe insert here
  @override
  Future<int> insertRecipe(Recipe recipe) {
    return Future(() async {
      final id = await dbHelper.insertRecipe(recipe);
      recipe.id = id;
      if (recipe.ingredients != null) {
        for (var ingredient in recipe.ingredients!) {
          ingredient.recipeId = id;
        }
        insertIngredients(recipe.ingredients!);
      }
      return id;
    });
  }

  //  Insert ingredients
  @override
  Future<List<int>> insertIngredients(List<Ingredient>
  ingredients) {
    return Future(() async {
      if (ingredients.isNotEmpty) {
        // 1
        final ingredientIds = <int>[];
        // 2
        await Future.forEach(ingredients, (Ingredient ingredient)
        async {
          // 3
          final futureId = await
          dbHelper.insertIngredient(ingredient);
          ingredient.id = futureId;
          // 4
          ingredientIds.add(futureId);
        });
        // 5
        return Future.value(ingredientIds);
      } else {
        return Future.value(<int>[]);
      }
    });
  }

  //  Delete methods go here
  @override
  Future<void> deleteRecipe(Recipe recipe) {
    dbHelper.deleteRecipe(recipe);
    if (recipe.id != null) {
      deleteRecipeIngredients(recipe.id!);
    }
    return Future.value();
  }
  @override
  Future<void> deleteIngredient(Ingredient ingredient) {
    dbHelper.deleteIngredient(ingredient);
    return Future.value();
  }
  @override
  Future<void> deleteIngredients(List<Ingredient> ingredients) {
    dbHelper.deleteIngredients(ingredients);
    return Future.value();
  }
  @override
  Future<void> deleteRecipeIngredients(int recipeId) {
    dbHelper.deleteRecipeIngredients(recipeId);
    return Future.value();
  }

  // initialize and close methods go here
  @override
  Future init() async {
    await dbHelper.database;
    return Future.value();
  }
  @override
  void close() {
    dbHelper.close();
  }
}