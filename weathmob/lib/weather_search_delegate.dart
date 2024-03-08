import 'package:flutter/material.dart';
import 'package:weathmob/data_service.dart';

import 'models.dart';

class WeatherSearchDelegate extends SearchDelegate {

  List<String> searchResults = [
    'Cairo',
    'Nairobi',
    'Accra',
    'Kigali',
    'Berlin'
  ];
  late Future<WeatherResponse> _response;

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
            onPressed: () {
              if(query.isEmpty) {
                close(context, null);
              } else {
                query = '';
              }

            },
            icon: const Icon(Icons.clear))
      ];

  @override
  Widget? buildLeading(BuildContext context) =>
      IconButton(onPressed: () => close(context,null), icon: const Icon(Icons.arrow_back));

  @override
  Widget buildResults(BuildContext context) {
    _response = DataService.getWeather(query);
    return FutureBuilder<WeatherResponse>(
    future: _response,
    builder: (context,snapshot) {
      if(snapshot.hasData) {
        return Center(
          child: Column(
            children: [
              Image.network(snapshot.data!.iconUrl, height: 200, width: 200, fit: BoxFit.fill,),
              const SizedBox(
                height: 2,
              ),
              Text(
                  snapshot.data!.name,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              // Text(snapshot.data!.weatherInfo.description),
              Text(
                  '${snapshot.data!.temperatureInfo.temperature}°C',
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ],
          ),
        );
      }
      // else if(snapshot.hasError) {
      //   return Text('${snapshot.error}');
      // }
      // By default, show a loading spinner.
      return const Center(child: CircularProgressIndicator());
    },
  );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = searchResults.where((element) {
      final result = element.toLowerCase();
      final input = query.toLowerCase();
      return result.contains(input);
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];
        return ListTile(
          title: Text(suggestion),
          onTap: () {
            query = suggestion;
            showResults(context);
          },
        );
      },
    );
  }
}
