import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather/weather.dart';
import 'package:http/http.dart' as http;

import 'constants.dart';

void main() {

  // a better error screen
  ErrorWidget.builder = (FlutterErrorDetails details) => Material(
    color: Colors.greenAccent.shade100,
    child: Center(
      child: Text(
        details.exceptionAsString(),
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 20,
          fontFamily: 'One UI Sans'
        ),
      ),
    ),
  );

  WidgetsFlutterBinding.ensureInitialized();
  // device orientations
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const WeatherApp());
}

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  late Future<Weather> futureWeather;
  late double longitude;
  late double latitude;

  @override
  void initState() {
    super.initState();
    futureWeather = fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather',
      theme: ThemeData(fontFamily: 'One UI Sans'),
      home: Scaffold(
        body: Container(
          color: Colors.grey,
          child: Center(
            child: FutureBuilder<Weather>(
              future: futureWeather,
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                  return Text(snapshot.data!.name);
                } else if(snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            )
          ),
        ),
      ),
    );
  }

  Future<Weather> fetchWeather() async {
    final response = await http
        .get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?'),
      headers: {
        HttpHeaders.authorizationHeader: AppConstants.API_KEY,
      }
    );
    // headers: {
    //       HttpHeaders.authorizationHeader: AppConstants.API_KEY,
    // },);
    // final responseJson = jsonDecode(response.body) as Map<String, dynamic>;
    // return Weather.fromJson(responseJson);
    if(response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Weather.fromJson(jsonEncode(response.body) as Map<String, dynamic>);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load weather');
    }
  }
}

