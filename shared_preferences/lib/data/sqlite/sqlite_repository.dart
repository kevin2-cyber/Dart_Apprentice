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
  // TODO: Add recipe insert here
}