import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:weathmob/data_service.dart';
import 'package:weathmob/models.dart';

class SearchResults extends StatefulWidget {
  final String query;
  const SearchResults({super.key, required this.query});

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  late Future<WeatherResponse> _response;
  int selectedIndex = 0;
  List<String> days = [
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat'
  ];

  @override
  void initState() {
    super.initState();
    fetchWeather();
    selectedIndex = 0;
  }

  void fetchWeather() async {
    try {
      setState(() {
        _response = DataService.getWeather(widget.query);
      });
    } catch(error) {
      // Handle error (e.g., display error message)
      if (kDebugMode) {
        print("Error fetching weather: <span class=\"$error\">error");
      }
    }

  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WeatherResponse>(
      future: _response,
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
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
                Text(
                  '${snapshot.data!.temperatureInfo.temperature}°C',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(left: 16, bottom: 5),
                  child: Wrap(
                    spacing: 5,
                    children: List.generate(days.length, (index) =>
                        ChoiceChip(
                            label: Text(
                                days[index],
                              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                                color:  Colors.black
                              ),
                            ),
                          selected: selectedIndex == index,
                          selectedColor: Colors.white38,
                          labelPadding: const EdgeInsets.all(2.0),
                          showCheckmark: false,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          elevation: selectedIndex == index ? 5 : 0,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            side: BorderSide(color: Colors.transparent),
                          ),
                          onSelected: (value) {
                              setState(() {
                                selectedIndex = value ? index : selectedIndex;
                              });
                          },
                        ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Row(
                    children: [
                      Text(
                          'Locations',
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                const LocationCard(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                const LocationCard(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                const LocationCard(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                const LocationCard(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                const LocationCard(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                const LocationCard(),
              ],
            ),
          );
        }
        return const Center(child: CircularProgressIndicator(),);
      },
    );
  }
}

class LocationCard extends StatelessWidget {
  const LocationCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: const BoxDecoration(
          color: Colors.black12,
        ),
        child: const ListTile(
          title: Text('32°C'),
          subtitle: Text('Hanoi'),
          trailing: Icon(Icons.sunny),
        ),
      ),
    );
  }
}
