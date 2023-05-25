import 'package:earthquake_project/earthquake_info.dart';
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
        title: Center(child: Text('Earthquakes Map',style: TextStyle(fontWeight: FontWeight.bold),),),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(38.32305766032805, 27.129734188970232),
          zoom: 6,
        ),
        mapType: MapType.satellite,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        compassEnabled: true,
        markers: <Marker>{
          const Marker(
            markerId: MarkerId('IZMIR'),
            position: LatLng(38.346550, 27.142309),
          infoWindow: InfoWindow(
            title: 'Izmir',
            snippet: 'Siddet: 0.0  || Derinlik: 0.0 '
          )
          )
        },
      ),
    );
  }
}
