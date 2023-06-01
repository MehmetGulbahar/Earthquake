import 'dart:convert';
import 'dart:math';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:earthquake_project/earthquake_card.dart';
import 'package:earthquake_project/earthquake_info.dart';
import 'package:earthquake_project/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'afad_card.dart';
import 'afad_home_page.dart';
import 'afad_info.dart';
import 'earthquake-video-info.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<EarthquakeInfo> earthquakeInfoList = [];
  List<EarthquakeInfo> filteredList = [];
  List<AfadInfo> afadInfoList = [];
  List<AfadInfo> afadfilteredList = [];
  bool _switchValue = false;



  final currentIndex = ValueNotifier<int>(0);

  Future<void> refreshAfadData() async {
    try {
      List<AfadInfo> earthquakeDataAfad = await afadEarthquake();
      setState(() {
        this.afadInfoList = earthquakeDataAfad;
        this.afadfilteredList = earthquakeDataAfad;
      });
    } catch (e) {
      print('Error: $e');
    }
    return Future.delayed(Duration(seconds: 1));
  }

  Future<void> refresh() async {
    var earthquakeJsonData = await earthquakeDataToJson();
    List earthquakeList = jsonDecode(earthquakeJsonData);
    List<EarthquakeInfo> earthquakeInfoList =
        earthquakeList.map((item) => EarthquakeInfo.fromJson(item)).toList();

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



  void filterData(String query) {
    setState(() {
      filteredList = earthquakeInfoList
          .where((item) =>
              item.location.toLowerCase().contains(query.toLowerCase()))
          .toList();
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
        SystemUiOverlayStyle(statusBarColor: Colors.deepPurple));
    return SizedBox(
      width: 200,
      height: 300,
      child: Padding(
        padding: EdgeInsets.all(1.0),
        child: Scaffold(
          bottomNavigationBar: _bottomNavigationBar(context),
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
                style: GoogleFonts.openSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                onChanged: (value) => filterData(value),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: min(50, filteredList.length),
                  itemBuilder: (context, index) =>
                      EarthQuakeCard(earthquakeInfo: filteredList[index]),
                ),
              ),
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
        onRefresh: () async {
          await refresh();
        },
        color: Colors.deepPurple,
        animSpeedFactor: 2,
        height: 200,
        showChildOpacityTransition: false,
        backgroundColor: Colors.deepOrangeAccent[200],
        child: ListView.builder(
          itemCount: min(50, filteredList.length),
          itemBuilder: (context, index) =>
              EarthQuakeCard(earthquakeInfo: earthquakeInfoList[index]),
        ),
      );

  PreferredSizeWidget get _appBar => AppBar(
    leading: IconButton(
      icon: Icon(CupertinoIcons.map),
      onPressed: () => Navigator.of(context).pushNamed('/show-all-earthquakes'),
    ),
    backgroundColor: Colors.deepPurple,
    title: Center(
      child: ToggleSwitch(
        minWidth: 90.0,
        minHeight: 90.0,
        cornerRadius: 60,
        activeBgColor: [Colors.purple],
        activeFgColor: Colors.white,
        inactiveBgColor: Colors.blueAccent,
        inactiveFgColor: Colors.white,
        labels: ['Kandilli', 'Afad'],
        icons: [CupertinoIcons.arrow_left_circle, CupertinoIcons.arrow_right_circle],
        onToggle: (index) {
          setState(() {
            _switchValue = index == 1;
          });
          if (_switchValue) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => AfadHomePage()),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage()),
            );
          }
        },
      ),
    ),
    actions: [
      IconButton(
        icon: Icon(CupertinoIcons.info_circle),
        onPressed: () => Navigator.of(context).pushNamed('/earthquake-info-video'),
      )
    ],
  );


}
