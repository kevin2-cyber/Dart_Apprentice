import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
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
  //TODO: Add code to open database
}