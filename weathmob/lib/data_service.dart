import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'models.dart';

class DataService {

  Future<WeatherResponse> getWeather(String city) async{
    // https://api.openweathermap.org/data/2.5/weather?q=London&appid={API key}

    await dotenv.load(fileName: 'assets/.env');

    String api = dotenv.get('API_KEY');

    final queryParameters = {'q':city,'appid':api};

    final uri = Uri.https(
      'api.openweathermap.org', 'data/2.5/weather',queryParameters
    );
    

    final response = await http.get(uri);
    if (kDebugMode) {
      print(response.body);
    }
    final json = jsonDecode(response.body);
    return WeatherResponse.fromJson(json);
    
  }
}