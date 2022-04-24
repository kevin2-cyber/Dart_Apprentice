import 'package:chopper/chopper.dart';

import 'model_response.dart';
import 'recipe_model.dart';
import 'model_converter.dart';
import 'service_interface.dart';
part 'recipe_service.chopper.dart';

const String apiKey = '42e9489a8d151c862665c2471e7a75b5';
const String apiId = '7f549a1e';
const String apiUrl = 'https://api.edamam.com/search';

// Add @ChopperApi() here
@ChopperApi()
abstract class RecipeService extends ChopperService implements ServiceInterface {
  @override
  @Get(path: 'search')
  Future<Response<Result<APIRecipeQuery>>> queryRecipes(
      @Query('q') String query,
      @Query('from') int from,
      @Query('to') int to,
      );
  // Add create()
  static RecipeService create() {
    final client = ChopperClient(
      baseUrl: apiUrl,
      interceptors: [_addQuery, HttpLoggingInterceptor()],
      converter: ModelConverter(),
      errorConverter: const JsonConverter(),
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
