import 'package:flutter/material.dart';
import 'package:earthquake_project/Kandilli%20Infos%20Card/models/earthquake_info.dart';
import 'package:earthquake_project/Kandilli%20Infos%20Card/screens/different_places_map.dart';
import 'package:hexcolor/hexcolor.dart';

class BuildTrailing extends StatelessWidget {
  const BuildTrailing({
    super.key,
    required this.earthquakeInfo,
  });

  final EarthquakeInfo earthquakeInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(70),
        color: HexColor("#393E46"),
      ),
      child: IconButton(
        color: Colors.black,
        icon: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.white,
        ),
        onPressed: () => DifferentPlaces().navigate(context, earthquakeInfo),
        tooltip: ('Show on Map'),
      ),
    );
  }
}
