import 'package:earthquake_project/Video%20Pages/earthquake-video-info.dart';
import 'package:earthquake_project/Map%20Show/show_all_earthquake.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'Afad Cards Infos/afad_home_page.dart';
import 'different_places_on_turkey/different_place_earthquake.dart';
import 'my_home_page.dart';

void main() {
  runApp(const MyApp());
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
      appBarTheme: AppBarTheme(color: HexColor("#00ADB5"))
      ),
      
      home: const MyHomePage(),
      routes: {
      '/show-all-earthquakes' : (context)  => const ShowAllEarthquakes(),
        '/different-places-on-Turkey': (context) => const SpecialPlace(),
        '/earthquake-info-video': (context) => const VideoInfo(),
      }
    );
  }
}
