import 'dart:convert';
import 'dart:math';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:earthquake_project/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'AfadInfo.dart';
import 'afad_card.dart';
import 'my_home_page.dart';
import 'earthquake-video-info.dart';

class AfadHomePage extends StatefulWidget {
  const AfadHomePage({Key? key}) : super(key: key);

  @override
  State<AfadHomePage> createState() => _AfadHomePageState();
}

class _AfadHomePageState extends State<AfadHomePage> {
  List<InfoAfad> afadInfoList = [];
  List<InfoAfad> afadfilteredList = [];
  bool _switchValue = false;
  final currentIndex = ValueNotifier<int>(0);

  Future<void> refreshAfadData() async {
    List<InfoAfad> afadInfoList = await fetchEarthquakes();

    setState(() {
      this.afadInfoList = afadInfoList;
      this.afadfilteredList = afadInfoList;
    });
  }


  void filterData(String query) {
    setState(() {
      afadfilteredList = afadInfoList.where((item) {
        return item.location.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    refreshAfadData();
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.blue.shade900));
    return SizedBox(
        width: 200,
        height: 300,
        child: Padding(
        padding: EdgeInsets.all(1.0),
    child: Scaffold(
    bottomNavigationBar: _bottomNavigationBar(context),
    appBar: _appBar,
      backgroundColor: Colors.blue.shade900,
      body: _body(context),
    )
        )
    );
  }
  Widget _bottomNavigationBar(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: Colors.blue.shade900,
      color: Colors.blue.shade700,
      height: 50,
      animationDuration: Duration(milliseconds: 400),
      items: [
        Icon(CupertinoIcons.home),
        Icon(CupertinoIcons.search),
        Icon(CupertinoIcons.settings)
      ],
      onTap: (index) {
        currentIndex.value = index;
        /*if (index == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SettingsPage(
                onNotificationsEnabledChanged: (bool value) {
                },
                notificationsEnabled: notificationsEnabled,
              ),
            ),
          );
        }*/
      },
    );
  }
  PreferredSizeWidget get _appBar => AppBar(
    leading: IconButton(
      icon: Icon(CupertinoIcons.map),
      onPressed: () => Navigator.of(context).pushNamed('/show-all-earthquakes'),
    ),
    backgroundColor: Colors.blue.shade700,
    title: Center(
      child: ToggleSwitch(
        minWidth: 90.0,
        minHeight: 90.0,
        fontSize: 16.0,
        cornerRadius: 35,
        initialLabelIndex: 1,
        activeBgColor:[Colors.blueAccent],
        activeFgColor: Colors.white,
        inactiveBgColor: Colors.purple,
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
                  itemCount: min(50, afadfilteredList.length),
                  itemBuilder: (context, index) =>
                      AfadCard(InfosAfad: afadInfoList[index]),
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
      await refreshAfadData();
    },
    color: Colors.blue.shade900,
    animSpeedFactor: 2,
    height: 200,
    showChildOpacityTransition: false,
    backgroundColor: Colors.blue.shade700,
    child:  ListView.builder(
      itemCount: min(50, afadfilteredList.length),
      itemBuilder: (context, index) =>
          AfadCard(InfosAfad: afadInfoList[index]),
    ),
  );


}

