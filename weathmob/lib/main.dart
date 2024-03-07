/*
 * Copyright Copenhagen Center for Health Technology (CACHET) at the
 * Technical University of Denmark (DTU).
 * Use of this source code is governed by a MIT-style license that can be
 * found in the LICENSE file.
 */
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

enum AppState { NOT_DOWNLOADED, DOWNLOADING, FINISHED_DOWNLOADING }

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String key = '78566aec1cd18b22bcd7735519ff7167';
  late WeatherFactory ws;
  List<Weather> _data = [];
  AppState _state = AppState.NOT_DOWNLOADED;
  double? lat, lon;

  @override
  void initState() {
    super.initState();
    ws = WeatherFactory(key);
  }

  void queryForecast() async {
    /// Removes keyboard
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      _state = AppState.DOWNLOADING;
    });

    List<Weather> forecasts = await ws.fiveDayForecastByLocation(lat!, lon!);
    setState(() {
      _data = forecasts;
      _state = AppState.FINISHED_DOWNLOADING;
    });
  }

  void queryWeather() async {
    /// Removes keyboard
    FocusScope.of(context).requestFocus(FocusNode());

    setState(() {
      _state = AppState.DOWNLOADING;
    });

    Weather weather = await ws.currentWeatherByLocation(lat!, lon!);
    setState(() {
      _data = [weather];
      _state = AppState.FINISHED_DOWNLOADING;
    });
  }

  Widget contentFinishedDownload() {
    return Center(
      child: ListView.separated(
        itemCount: _data.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_data[index].toString()),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
      ),
    );
  }

  Widget contentDownloading() {
    return Container(
      margin: const EdgeInsets.all(25),
      child: Column(children: [
        const Text(
          'Fetching Weather...',
          style: TextStyle(fontSize: 20),
        ),
        Container(
            margin: const EdgeInsets.only(top: 50),
            child: const Center(child: CircularProgressIndicator(strokeWidth: 10)))
      ]),
    );
  }

  Widget contentNotDownloaded() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Press the button to download the Weather forecast',
          ),
        ],
      ),
    );
  }

  Widget _resultView() => _state == AppState.FINISHED_DOWNLOADING
      ? contentFinishedDownload()
      : _state == AppState.DOWNLOADING
      ? contentDownloading()
      : contentNotDownloaded();

  void _saveLat(String input) {
    lat = double.tryParse(input);
    if (kDebugMode) {
      print(lat);
    }
  }

  void _saveLon(String input) {
    lon = double.tryParse(input);
    if (kDebugMode) {
      print(lon);
    }
  }

  Widget _coordinateInputs() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
              margin: const EdgeInsets.all(5),
              child: TextField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Enter latitude'),
                  keyboardType: TextInputType.number,
                  onChanged: _saveLat,
                  onSubmitted: _saveLat)),
        ),
        Expanded(
            child: Container(
                margin: const EdgeInsets.all(5),
                child: TextField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter longitude'),
                    keyboardType: TextInputType.number,
                    onChanged: _saveLon,
                    onSubmitted: _saveLon)))
      ],
    );
  }

  Widget _buttons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(5),
          child: TextButton(
            onPressed: queryWeather,
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue)),
            child: const Text(
              'Fetch weather',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(5),
          child: TextButton(
            onPressed: queryForecast,
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue)),
            child: const Text(
              'Fetch forecast',
              style: TextStyle(color: Colors.white),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather mob',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Weather Example App'),
        ),
        body: Column(
          children: <Widget>[
            _coordinateInputs(),
            _buttons(),
            const Text(
              'Output:',
              style: TextStyle(fontSize: 20),
            ),
            const Divider(
              height: 20.0,
              thickness: 2.0,
            ),
            Expanded(child: _resultView())
          ],
        ),
      ),
    );
  }
}