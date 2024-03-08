import 'package:flutter/material.dart';
import 'package:weathmob/weather_search_delegate.dart';

import 'data_service.dart';
import 'models.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
          onPressed: ()=> showSearch(
                context: context,
                delegate: WeatherSearchDelegate()),
              icon: const Icon(Icons.search)
          ),
        ],
      ),
      body: Center(
        child: Text(
            'Search city',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      // body: Center(
      //   child: Column(
      //     children: [
      //       // Padding(
      //       //   padding: const EdgeInsets.all(16.0),
      //       //   child: TextFormField(
      //       //     controller: _cityTextController,
      //       //   ),
      //       // ),
      //       // ElevatedButton(
      //       //     onPressed: search,
      //       //     child: const Text('Search'),
      //       // ),
      //       FutureBuilder<WeatherResponse>(
      //         future: _response,
      //         builder: (context,snapshot) {
      //           if(snapshot.hasData) {
      //             return Column(
      //               children: [
      //                 Image.network(snapshot.data!.iconUrl, height: 50, width: 50,),
      //                 Text(snapshot.data!.weatherInfo.description),
      //                 Text('${snapshot.data!.temperatureInfo.temperature}°C'),
      //               ],
      //             );
      //           }
      //           // else if(snapshot.hasError) {
      //           //   return Text('${snapshot.error}');
      //           // }
      //           // By default, show a loading spinner.
      //           return const CircularProgressIndicator();
      //         },
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
