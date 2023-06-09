import 'dart:convert';

import 'package:earthquake_project/Kandilli%20Infos%20Card/earthquake_info.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShowAllEarthquakes extends StatefulWidget {
  const ShowAllEarthquakes({Key? key}) : super(key: key);

  @override
  State<ShowAllEarthquakes> createState() => _ShowAllEarthquakesState();
}

class _ShowAllEarthquakesState extends State<ShowAllEarthquakes> {

  List<Marker> markers = [];

  @override
  void initState() {
    super.initState();
    earthquakeDataToJson().then((response) {
      List<dynamic> data = jsonDecode(response);
      List<EarthquakeInfo> earthquakeInfos =
      data.map((e) => EarthquakeInfo.fromJson(e)).toList();
      setState(() {
        markers = earthquakeInfos.map((e) {
          Marker marker = Marker(
            markerId: MarkerId(e.location),
            position: LatLng(
                double.parse(e.latitude), double.parse(e.longitude)),
            infoWindow: InfoWindow(
              title: e.location,
              snippet: 'Magnitude: ${e.ml}  || Depth: ${e.depth} ',
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),

          );
          markers.add(marker);
          return marker;
        }).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[300],
        title: Center(child: Text('Earthquakes Map',
          style: GoogleFonts.openSans(
              fontWeight: FontWeight.bold, fontSize: 20),),),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(38.32305766032805, 27.129734188970232),
          zoom: 6,
        ),
        mapType: MapType.hybrid,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        compassEnabled: true,
       markers: Set.of(markers),

      ),
    );
  }
}