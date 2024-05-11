import 'dart:convert';
import 'dart:math';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:earthquake_project/Kandilli%20Infos%20Card/earthquake_card.dart';
import 'package:earthquake_project/Kandilli%20Infos%20Card/models/earthquake_info.dart';
import 'package:earthquake_project/Settings/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'Afad Cards Infos/afad_home_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<EarthquakeInfo> earthquakeInfoList = [];
  List<EarthquakeInfo> filteredList = [];
  bool _switchValue = false;
  FlutterLocalNotificationsPlugin kandilliLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  bool notificationsEnabled = true;

  void handleNotificationsEnabledChanged(bool value) {
    setState(() {
      notificationsEnabled = value;
    });
  }

  final currentIndex = ValueNotifier<int>(0);

  Future<void> refresh() async {
    var earthquakeJsonData = await earthquakeDataToJson();
    List earthquakeList = jsonDecode(earthquakeJsonData);
    List<EarthquakeInfo> earthquakeInfoList =
        earthquakeList.map((item) => EarthquakeInfo.fromJson(item)).toList();

    setState(() {
      this.earthquakeInfoList = earthquakeInfoList;
      filteredList = earthquakeInfoList;
    });
    if (earthquakeInfoList.isNotEmpty) {
      showNotification(
          earthquakeInfoList[0].location, earthquakeInfoList[0].ml);
    }
    return Future.delayed(const Duration(seconds: 1));
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

  void showNotification(String location, String magnitude) async {
    if (!notificationsEnabled) {
      return;
    }
    var prefs = await SharedPreferences.getInstance();

    var previousLocation = prefs.getString('previousLocation');
    var previousMagnitude = prefs.getString('previousMagnitude');

    if (previousLocation == location && previousMagnitude == magnitude) {
      return;
    }

    var androidDetails = const AndroidNotificationDetails(
      'channelId',
      'Earthquake',
      channelDescription: 'channelDescription',
      importance: Importance.max,
      priority: Priority.high,
      icon: 'earthquake',
      styleInformation: BigTextStyleInformation(''),
    );
    var notificationDetails = NotificationDetails(android: androidDetails);

    await kandilliLocalNotificationsPlugin.show(
      0,
      'KANDILLI!',
      'Location: $location\nMagnitude: $magnitude',
      notificationDetails,
    );

    // Store the details of the current notification
    prefs.setString('previousLocation', location);
    prefs.setString('previousMagnitude', magnitude);
  }

  @override
  void initState() {
    super.initState();
    refresh();
    askUserLocation();
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        notificationsEnabled = prefs.getBool('notificationsEnabled') ?? true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.grey));
    return SizedBox(
      width: 200,
      height: 300,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Scaffold(
          bottomNavigationBar: _bottomNavigationBar(context),
          appBar: _appBar,
          backgroundColor: Colors.white,
          body: _body(context),
        ),
      ),
    );
  }

  Widget _bottomNavigationBar(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: HexColor("#222831"),
      color: HexColor("#EEEEEE"),
      height: 50,
      animationDuration: const Duration(milliseconds: 400),
      items: const [
        Icon(CupertinoIcons.home),
        Icon(CupertinoIcons.search),
        Icon(CupertinoIcons.settings)
      ],
      onTap: (index) {
        currentIndex.value = index;
        if (index == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SettingsPage(
                onNotificationsEnabledChanged:
                    handleNotificationsEnabledChanged,
                notificationsEnabled: notificationsEnabled,
              ),
            ),
          );
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
                decoration: const InputDecoration(
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
          icon: const Icon(CupertinoIcons.map),
          onPressed: () =>
              Navigator.of(context).pushNamed('/show-all-earthquakes'),
        ),
        title: Center(
          child: ToggleSwitch(
            initialLabelIndex: 1,
            totalSwitches: 2,
            labels: const ['Kandilli', 'Afad'],
            onToggle: (index) {
              setState(() {
                _switchValue = index == 1;
              });
              if (_switchValue) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const AfadHomePage()),
                );
              } else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MyHomePage()),
                );
              }
            },
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.info_circle),
            onPressed: () =>
                Navigator.of(context).pushNamed('/earthquake-info-video'),
          )
        ],
      );
}
