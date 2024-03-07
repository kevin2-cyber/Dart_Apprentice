import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weathmob/data_service.dart';

Future<void> main() async {
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

  runApp(const WeathMob());
}

class WeathMob extends StatefulWidget {
  const WeathMob({super.key});

  @override
  State<WeathMob> createState() => _WeathMobState();
}

class _WeathMobState extends State<WeathMob> {
  final _dataService = DataService();
  final _cityTextController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WeathMob',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'One UI Sans'
      ),
      home: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.indigo.shade50,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: TextFormField(
                    controller: _cityTextController,
                    decoration: InputDecoration(),
                  ),
                ),
                ElevatedButton(onPressed: search, child: const Text('Search'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void search() async {
    final response = await _dataService.getWeather(_cityTextController.text);
    if (kDebugMode) {
      print(response.name);
      print(response.temperatureInfo.temperature);
      print(response.weatherInfo.description);
    }
  }
}
