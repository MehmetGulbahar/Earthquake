import 'dart:convert';

import 'package:earthquake_project/earthquake_card.dart';
import 'package:earthquake_project/earthquake_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<EarthquakeInfo> earthquakeInfoList = [];

  void fetchData() async {
    var earthquakeJsonData = await earthquakeDataToJson();
    List earthquakeList = jsonDecode(earthquakeJsonData);
    List<EarthquakeInfo> earthquakeInfoList = earthquakeList.map((item) => EarthquakeInfo.fromJson(item)).toList();

    setState(() {
      this.earthquakeInfoList = earthquakeInfoList;
    });
  }


  void askUserLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied) {
      // Handle the case when the user denies location permission
    } else {
      // The user has granted location permission
    }
  }
  @override
  void initState() {
    super.initState();
    fetchData();
    askUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.purple[900]));
    return Scaffold(
      appBar: _appBar,
      body: ListView.builder(
        itemCount: earthquakeInfoList.length,
        itemBuilder: (context, index) =>
            EarthQuakeCard(earthquakeInfo: earthquakeInfoList[index]),
      ),
    );
  }

  PreferredSizeWidget get _appBar => AppBar(
    title: Center(child: Text('EARTHQUAKE')),
    actions: [
      IconButton(
          icon: Icon(CupertinoIcons.map),
          onPressed: () =>
              Navigator.of(context).pushNamed('/show-all-earthquakes')),
      IconButton(onPressed: null, icon: Icon(Icons.refresh)),
    ],
  );
}
