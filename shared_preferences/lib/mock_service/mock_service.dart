import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:chopper/chopper.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../network/model_response.dart';
import '../network/recipe_model.dart';

class MockService {
  late APIRecipeQuery _currentRecipes1;
  late APIRecipeQuery _currentRecipes2;
  Random nextRecipe = Random();

  //TODO: Add create and load methods
  //TODO: Add query method
}