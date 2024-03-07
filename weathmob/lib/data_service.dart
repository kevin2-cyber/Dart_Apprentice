import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'models.dart';

class DataService {
  Future<WeatherResponse> getWeather(String city) async{
    // https://api.openweathermap.org/data/2.5/weather?q=London&appid={API key}

    final queryParameters = {'q':city,'appid':'78566aec1cd18b22bcd7735519ff7167'};

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