import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlbrite/sqlbrite.dart';
import 'package:synchronized/synchronized.dart';
import '../models/models.dart';

class DatabaseHelper {
  static const _databaseName = 'MyRecipes.db';
  static const _databaseVersion = 1;
  static const recipeTable = 'Recipe';
  static const ingredientTable = 'Ingredient';
  static const recipeId = 'recipeId';
  static const ingredientId = 'ingredientId';
  static late BriteDatabase _streamDatabase;

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance =
  DatabaseHelper._privateConstructor();
  static var lock = Lock();

  // only have a single app-wide reference to the database
  static Database? _database;

  // Add create database code here
  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute(
      '''
      CREATE TABLE $recipeTable (
        $recipeId INTEGER PRIMARY KEY,
        label TEXT,
        image TEXT,
        url TEXT,
        calories REAL,
        totalWeight REAL,
        totalTime REAL
      )
      '''
    );
    await db.execute(
      '''
      CREATE TABLE $ingredientTable(
        $ingredientId INTEGER PRIMARY KEY,
        $recipeId INTEGER,
        name TEXT,
        weight REAL
      )
      '''
    );
  }

  // Add code to open database
  // this opens the database (and creates it if it doesn't exist)
  Future<Database> _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);
    // TODO: Remember to turn off debugging before deploying app to store(s).
    Sqflite.setDebugModeOn(true);
    return openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  // Add initialize getter here
  Future<Database> get database async {
    if (_database != null) return _database!;
    // Use this object to prevent concurrent access to data
    await lock.synchronized(() async {
      if (_database == null) {
        _database = await _initDatabase();
        _streamDatabase = BriteDatabase(_database!);
      }
    });
    return _database!;
  }

  // Add getter for streamDatabase
  Future<BriteDatabase> get streamDatabase async {
    await database;
    return _streamDatabase;
  }

  // Add parseRecipes here
  List<Recipe> parseRecipes(List<Map<String, dynamic>> recipeList) {
    final recipes = <Recipe>[];
    for (var recipeMap in recipeList) {
      final recipe = Recipe.fromJson(recipeMap);
      recipes.add(recipe);
    }
    return recipes;
  }

  List<Ingredient> parseIngredients(List<Map<String, dynamic>> ingredientList) {
    final ingredients = <Ingredient>[];
    for (var ingredientMap in ingredientList) {
      final ingredient = Ingredient.fromJson(ingredientMap);
      ingredients.add(ingredient);
    }
    return ingredients;
  }

  // Add findAllRecipes here
  Future<List<Recipe>> findAllRecipes() async {
    final db = await instance.streamDatabase;
    final recipeList = await db.query(recipeTable);
    final recipes = parseRecipes(recipeList);
    return recipes;
  }
}
// Add watchAllRecipes() here
  Stream<List<Recipe>> watchAllRecipes() async* {
  final db = await instance.streamDatabase;
  yield* db
      .createQuery(recipeTable)
      .mapToList((row) => Recipe.fromJson(row));
  }

  // Add watchAllIngredients() here
  Stream<List<Ingredient>> watchAllIngredients() async* {
  final db = await instance.streamDatabase;
  yield* db
      .createQuery(ingredientTable)
      .mapToList((row) => Ingredient.fromJson(row));
  }

  // Add findRecipeByID() here
  Future<Recipe> findRecipeById(int id) async {
  final db = await instance.streamDatabase;
  final recipeList = await db.query(recipeTable,where: 'id = $id');
  final recipes = parseRecipes(recipeList);
  return recipes.first;
  }

  // Put findAllIngredients() here
  Future<List<Ingredient>> findAllIngredients() async {
  final db = await instance.streamDatabase;
  final ingredientList = await db.query(ingredientTable);
  final ingredients = parseIngredients(ingredientList);
  return ingredients;
  }

  //findRecipeIngredients() here
  Future<List<Ingredient>> findRecipeIngredients(int recipeId) async {
  final db = await instance.streamDatabase;
  final ingredientList = await db.query(ingredientTable, where: 'recipeId = $recipeId');
  final ingredients = parseIngredients(ingredientList);
  return ingredients;
  }

  // Insert methods go here
  Future<int> insert(String table, Map<String, dynamic> row) async {
    final db = await instance.streamDatabase;
    return db.insert(table, row);
  }
  Future<int> insertRecipe(Recipe recipe) {
    return insert(recipeTable, recipe.toJson());
  }
  Future<int> insertIngredient(Ingredient ingredient) {
    return insert(ingredientTable, ingredient.toJson());
  }

  // Delete methods go here
  Future<int> _delete(String table, String columnId, int id) async {
    final db = await instance.streamDatabase;
    return db.delete(table, where: '$columnId = ?',whereArgs: [id]);
  }
  Future<int> deleteRecipe(Recipe recipe) async {
    if (recipe.id != null) {
      return _delete(recipeTable, recipeId, recipe.id!);
    } else {
      return Future.value(-1);
    }
  }
  Future<int> deleteIngredient(Ingredient ingredient) async {
    if (ingredient.id != null) {
      return _delete(ingredientTable, ingredientId,
          ingredient.id!);
    } else {
      return Future.value(-1);
    }
  }
  Future<void> deleteIngredients(List<Ingredient> ingredients) {
    for (var ingredient in ingredients) {
      if (ingredient.id != null) {
        _delete(ingredientTable, ingredientId, ingredient.id!);
      }
    }
    return Future.value();
  }
  Future<int> deleteRecipeIngredients(int id) async {
    final db = await instance.streamDatabase;
    return db
        .delete(ingredientTable, where: '$recipeId = ?',
        whereArgs: [id]);
  }

  // Add close() here
  void close() {
    _streamDatabase.close();
  }