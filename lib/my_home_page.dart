import 'dart:convert';
import 'dart:math';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:earthquake_project/earthquake_card.dart';
import 'package:earthquake_project/earthquake_info.dart';
import 'package:earthquake_project/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import 'navbar_menu.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<EarthquakeInfo> earthquakeInfoList = [];
  List<EarthquakeInfo> filteredList = [];
  final currentIndex = ValueNotifier<int>(0);


  /*void fetchData() async {
    var earthquakeJsonData = await earthquakeDataToJson();
    List earthquakeList = jsonDecode(earthquakeJsonData);
    List<EarthquakeInfo> earthquakeInfoList = earthquakeList.map((item) => EarthquakeInfo.fromJson(item)).toList();

    setState(() {
      this.earthquakeInfoList = earthquakeInfoList;
    });
 }  */
Future<void> refresh() async{
    var earthquakeJsonData = await earthquakeDataToJson();
    List earthquakeList = jsonDecode(earthquakeJsonData);
    List<EarthquakeInfo> earthquakeInfoList = earthquakeList.map((item) => EarthquakeInfo.fromJson(item)).toList();

    setState(() {
      this.earthquakeInfoList = earthquakeInfoList;
      this.filteredList = earthquakeInfoList;


    });
    return Future.delayed(Duration(seconds: 1));
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
  void filterData(String query){
  setState(() {
    filteredList = earthquakeInfoList.where((item) => item.location.toLowerCase().contains(query.toLowerCase())).toList();
  });
  }
  @override
  void initState() {
    super.initState();
    refresh();
    askUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.blue));
    return SizedBox(
      width: 200,
      height: 300,
      child: Padding(
        padding: EdgeInsets.all(1.0),
        child: Scaffold(
          bottomNavigationBar: _bottomNavigationBar(context),
          drawer: NavBar(),
          appBar: _appBar,
          backgroundColor: Colors.deepPurple[200],
          body: _body(context),
        ),
      ),
    );
  }

  Widget _bottomNavigationBar(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: Colors.deepPurple,
      color: Colors.deepPurple.shade200,
      height: 50,
      animationDuration: Duration(milliseconds: 400),
      items: [
        Icon(CupertinoIcons.home),
        Icon(CupertinoIcons.search),
        Icon(CupertinoIcons.settings)
      ],
      onTap: (index) {
        currentIndex.value = index;
        if (index == 2) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SettingsPage()));
        }
      },
    );
  }

  Widget _body(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: currentIndex,
      builder: (context, value, child) {
        if (value == 1) {
          return Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  filled: true,
                  fillColor: Colors.white,
                ),
                style:
                GoogleFonts.openSans(fontWeight: FontWeight.bold, fontSize: 18),
                onChanged: (value) => filterData(value),
              ),
              Expanded(child: ListView.builder(
                itemCount: min(50, filteredList.length),
                itemBuilder: (context, index) =>
                    EarthQuakeCard(earthquakeInfo: filteredList[index]),
              )),
            ],
          );
        } else if (value == 0) {
          return _refreshIndicator;
        } else {
          return Container();
        }
      },
    );
  }


  LiquidPullToRefresh get _refreshIndicator => LiquidPullToRefresh(
    onRefresh: refresh,
    color: Colors.deepPurple,
    animSpeedFactor: 2,
    height: 200,
    backgroundColor: Colors.deepOrangeAccent[200],
    child: ListView.builder(
      itemCount: min(50, filteredList.length),
      itemBuilder: (context, index) =>
          EarthQuakeCard(earthquakeInfo: filteredList[index]),
    ),
  );
  PreferredSizeWidget get _appBar => AppBar(
    backgroundColor: Colors.deepPurple[300],
    title: Center(child: Text('EARTHQUAKE',style: GoogleFonts.openSans(fontWeight: FontWeight.bold),),),

    actions: [
      IconButton(
          icon: Icon(CupertinoIcons.map),
          onPressed: () =>
              Navigator.of(context).pushNamed('/show-all-earthquakes')),
    ],
  );
}
