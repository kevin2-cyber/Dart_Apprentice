import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import '../src/menu.dart';
import '../src/navigation_controls.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../src/web_view_stack.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WebViewApp(),
    ),
  );
}

class WebViewApp extends StatefulWidget {
  const WebViewApp({Key? key}) : super(key: key);

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  final controller = Completer<WebViewController>();

  // @override
  // void initState(){
  //   if (Platform.isAndroid){
  //     WebView.platform = SurfaceAndroidWebView();
  //   }
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Flutter WebView'),
        actions: [
          NavigationControls(controller: controller),
          Menu(controller: controller),
        ],
      ),
      body: WebViewStack(controller: controller,),
    );
  }
}