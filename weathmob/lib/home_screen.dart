import 'package:flutter/material.dart';

import 'data_service.dart';
import 'models.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _cityTextController = TextEditingController();
  late Future<WeatherResponse> _response;

  @override
  void initState() {
    super.initState();
    search();
  }

  void search() async {
    setState(() {
      _response = DataService.getWeather(_cityTextController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: _cityTextController,
              ),
            ),
            ElevatedButton(
                onPressed: search,
                child: const Text('Search'),
            ),
            FutureBuilder<WeatherResponse>(
              future: _response,
              builder: (context,snapshot) {
                if(snapshot.hasData) {
                  return Column(
                    children: [
                      Image.asset(snapshot.data!.weatherInfo.icon),
                      Text(snapshot.data!.weatherInfo.description),
                    ],
                  );
                } else if(snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}
