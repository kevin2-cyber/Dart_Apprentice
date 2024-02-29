import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:peaky/home.dart';
import '../util/constants.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // @override
  // void initState() {
  //   super.initState();
  //   loadImage('${AppConstants.kDummyData[_selectedIndex].image}');
  // }
  //
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   loadImage('${AppConstants.kDummyData[_selectedIndex].image}');
  // }
final widgetOptions = [
  const HomeScreen(),

  const SafeArea(
    child: Center(
      child: Text(
        'Will Implement this feature soon',
        style: TextStyle(
          color: Colors.black54,
          fontSize: 50,
        ),
      ),
    ),
  ),

  const SafeArea(
    child: Center(
      child: Text(
        'Will Implement this feature soon',
        style: TextStyle(
          color: Colors.black54,
          fontSize: 50,
        ),
      ),
    ),
  ),

  const SafeArea(
    child: Center(
      child: Text(
        'Will Implement this feature soon',
        style: TextStyle(
          color: Colors.black54,
          fontSize: 50,
        ),
      ),
    ),
  ),
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(icon: Image.asset(AppConstants.home, height: 24, width: 24,), label: 'Home'),
          BottomNavigationBarItem(icon: Image.asset(AppConstants.search, height: 24, width: 24,), label: 'Search'),
          BottomNavigationBarItem(icon: Image.asset(AppConstants.location, height: 24, width: 24,), label: 'Location'),
          BottomNavigationBarItem(icon: Image.asset(AppConstants.user, height: 24, width: 24,), label: 'Profile')
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Future<void> loadImage(String imageUrl) async {
    try {
      // load the image
      await precacheImage(AssetImage(imageUrl), context);

      if (kDebugMode) {
        print('Image loaded and cached successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Failed to load and cache the image: $e');
      }
    }
  }
}
