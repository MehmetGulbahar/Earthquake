import 'package:earthquake_project/show_all_earthquake.dart';
import 'package:flutter/material.dart';

import 'my_home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EARTHQUAKE',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: const MyHomePage(),
      routes: {
      '/show-all-earthquakes' : (context)  => const ShowAllEarthquakes(),
      }
    );
  }
}
