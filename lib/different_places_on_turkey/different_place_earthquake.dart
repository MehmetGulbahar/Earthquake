import 'package:earthquake_project/ScreenArguments/ScreenArguments.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SpecialPlace extends StatefulWidget {
  const SpecialPlace({Key? key}) : super(key: key);

  @override
  State<SpecialPlace> createState() => _SpecialPlaceState();
}

class _SpecialPlaceState extends State<SpecialPlace> {
  @override
  Widget build(BuildContext context) {
   final ScreenArguments args = ModalRoute.of(context)?.settings.arguments as ScreenArguments;
    return Scaffold(
      backgroundColor: Colors.deepPurple[300],
      appBar: _appBar,
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(args.latitude,args.longitude),
          zoom: 8,
        ),
        markers: {
          Marker(
            markerId: MarkerId(args.place),
            position: LatLng(args.latitude,args.longitude),
            infoWindow: InfoWindow(
              title: args.place,
              snippet: 'Magnitude ${args.ml} || Depth ${args.depth}'
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
          )
        },

      ),
    );
  }
}
PreferredSizeWidget get _appBar => AppBar(
backgroundColor: Colors.deepPurple[300],
title: Center(child: Text('TURKEY MAP',style: GoogleFonts.openSans(fontWeight: FontWeight.bold),),),);