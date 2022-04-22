

import 'package:chopper/chopper.dart';
import 'package:recipe_finder/network/model_response.dart';
import 'package:recipe_finder/network/recipe_model.dart';

import 'model_converter.dart';
part 'recipe_service.chopper.dart';

const String apiKey = '17f4f0eac73106858bc0fee7046a76bc	';
const String apiId = 'a40e958e';
const String apiUrl = 'https://api.edamam.com/seach';

// Add @ChopperApi() here
@ChopperApi()
abstract class RecipeService extends ChopperService {
  @Get(path: 'search')
  Future<Response<Result<APIRecipeQuery>>> queryRecipes(
      @Query('q') String query,
      @Query('from') int from,
      @Query('to') int to,
      );
  // Add create()
  static RecipeService create() {
    // 1
    final client = ChopperClient(
      // 2
      baseUrl: apiUrl,
      // 3
      interceptors: [_addQuery, HttpLoggingInterceptor()],
      // 4
      converter: ModelConverter(),
      // 5
      errorConverter: const JsonConverter(),
      // 6
      services: [
        _$RecipeService(),
      ],
    );
    // 7
    return _$RecipeService(client);
  }
}
// Add _addQuery()
Request _addQuery(Request req) {
  final params = Map<String, dynamic>.from(req.parameters);
  params['app_id'] = apiId;
  params['app_key'] = apiKey;
  return req.copyWith(parameters: params);
}
