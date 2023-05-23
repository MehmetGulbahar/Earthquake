import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShowAllEarthquakes extends StatefulWidget {
  const ShowAllEarthquakes({Key? key}) : super(key: key);

  @override
  State<ShowAllEarthquakes> createState() => _ShowAllEarthquakesState();
}

class _ShowAllEarthquakesState extends State<ShowAllEarthquakes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Earthquakes'),
      ),
      body: const GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(38.32305766032805, 27.129734188970232),
          zoom: 8,
        ),
        mapType: MapType.hybrid,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
      ),
    );
  }
}
