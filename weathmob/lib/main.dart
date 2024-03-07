import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weathmob/home_screen.dart';

void main() async {
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WeathMob',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'One UI Sans'),
      home: const HomeScreen(),
    );
  }
}
