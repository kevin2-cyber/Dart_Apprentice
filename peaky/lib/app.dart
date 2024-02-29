import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../welcome.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(
        useMaterial3: true
      ).copyWith(
        textTheme: GoogleFonts.workSansTextTheme()
      ),
      home: const WelcomeScreen(),
    );
  }
}
