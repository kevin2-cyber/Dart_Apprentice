import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weathmob/data_service.dart';
import 'package:weathmob/models.dart';

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
                fontFamily: 'One UI Sans'),
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
  late WeatherResponse _response;

  @override
  void initState() {
    super.initState();
    search();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WeathMob',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'One UI Sans'),
      home: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.indigo.shade50,
          child: Center(
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                '${_response.temperatureInfo.temperature}',
                textAlign: TextAlign.start,
                textDirection: TextDirection.ltr,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontFamily: 'One UI Sans',
                ),
              ),
                Text(
                  _response.weatherInfo.description,
                  textAlign: TextAlign.start,
                  textDirection: TextDirection.ltr,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: TextFormField(
                    controller: _cityTextController,
                    decoration: const InputDecoration(),
                  ),
                ),
                ElevatedButton(
                  onPressed: search,
                  child: Text(
                    'Search',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(fontFamily: 'One UI Sans',),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void search() async {
    final response = await _dataService.getWeather(_cityTextController.text);
    setState(() {
      _response = response;
    });
  }
}
