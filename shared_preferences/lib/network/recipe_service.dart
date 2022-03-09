import 'package:http/http.dart';

const String apiKey = '17f4f0eac73106858bc0fee7046a76bc	';
const String apiID = 'a40e958e';
const String apiURL = 'https://api.edamam.com/seach';

class RecipeService {
  Future getData(String url) async {
    print('Calling url: $url');
    final response = await get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      print(response.statusCode);
    }
  }

  // Add getRecipes
  Future<dynamic> getRecipes(String query, int from, int to) async {
    final recipeData = await getData(
        '$apiURL? app_ID = $apiID&app_key=$apiKey&q=$query&from=$from&to=$to'
    );
    return recipeData;
  }
}
