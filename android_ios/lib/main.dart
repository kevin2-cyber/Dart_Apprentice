import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
     if(Platform.isAndroid) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Container(
            color: Colors.blueGrey,
          ),
        ),
      );
    } else if (Platform.isIOS) {
     return CupertinoApp(
       debugShowCheckedModeBanner: false,
       home: CupertinoPageScaffold(
         child: Container(
           color: Colors.red,
         ),
       ),
     );
    } else {
      return MaterialApp(
        home: Scaffold(
          body: Container(
            color: Colors.white,
          ),
        ),
      );
    }
  }
}