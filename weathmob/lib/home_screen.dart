import 'package:flutter/material.dart';
import 'package:weathmob/weather_search_delegate.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
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
    );
  }
}
