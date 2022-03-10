

import 'package:chopper/chopper.dart';
import 'package:recipe_finder/network/model_response.dart';
import 'package:recipe_finder/network/recipe_model.dart';

const String apiKey = '17f4f0eac73106858bc0fee7046a76bc	';
const String apiID = 'a40e958e';
const String apiURL = 'https://api.edamam.com/seach';

// Add @ChopperApi() here
@ChopperApi()
abstract class RecipeService extends ChopperService {
  @Get(path: 'search')
  Future<Response<Result<APIRecipeQuery>>> queryRecipes(
      @Query('q') String query,
      @Query('from') int from,
      @Query('to') int to,
      );
  //TODO: Add create()
}
//TODO: Add _addQuery()
