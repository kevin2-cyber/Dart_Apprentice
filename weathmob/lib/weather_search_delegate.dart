import 'package:flutter/material.dart';
import 'package:weathmob/search_results.dart';

class WeatherSearchDelegate extends SearchDelegate {

  List<String> searchResults = [
    'Cairo',
    'Nairobi',
    'Accra',
    'Kigali',
    'Berlin'
  ];


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
  Widget buildResults(BuildContext context) => SearchResults(query: query);
  //   _response = DataService.getWeather(query);
  //   return FutureBuilder<WeatherResponse>(
  //   future: _response,
  //   builder: (context,snapshot) {
  //     if(snapshot.hasData) {
  //       return Center(
  //         child: Column(
  //           children: [
  //             Image.network(snapshot.data!.iconUrl, height: 200, width: 200, fit: BoxFit.fill,),
  //             const SizedBox(
  //               height: 2,
  //             ),
  //             Text(
  //                 snapshot.data!.name,
  //               style: Theme.of(context).textTheme.headlineSmall,
  //             ),
  //             // Text(snapshot.data!.weatherInfo.description),
  //             Text(
  //                 '${snapshot.data!.temperatureInfo.temperature}°C',
  //               style: Theme.of(context).textTheme.displaySmall,
  //             ),
  //             SizedBox(
  //               height: MediaQuery.of(context).size.height * 0.02,
  //             ),
  //
  //             ListView.builder(
  //               scrollDirection: Axis.horizontal,
  //               itemCount: days.length,
  //               itemBuilder: (context, index) {
  //                 return ChoiceChip(
  //                     label: Text(days[index]),
  //                     selected: selectedIndex == index,
  //                   selectedColor: Colors.deepPurple,
  //                   onSelected: (value) {
  //                       selectedIndex = value ? index : selectedIndex;
  //                   },
  //                   padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.04),
  //                 );
  //               },
  //             ),
  //             const ChoiceChip(label: Text('Sun'), selected: false),
  //           ],
  //         ),
  //       );
  //     }
  //     // By default, show a loading spinner.
  //     return const Center(child: CircularProgressIndicator());
  //   },
  // );


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
