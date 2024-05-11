import 'package:earthquake_project/Kandilli%20Infos%20Card/models/earthquake_info.dart';
import 'package:earthquake_project/ScreenArguments/ScreenArguments.dart';
import 'package:flutter/material.dart';

class NavigationHelper {
  static void navigateToDifferentPlaces(
      BuildContext context, EarthquakeInfo earthquakeInfo) {
    Navigator.of(context).pushNamed(
      '/different-places-on-Turkey',
      arguments: ScreenArguments(
        depth: earthquakeInfo.depth,
        ml: earthquakeInfo.ml,
        place: earthquakeInfo.location,
        latitude: double.parse(earthquakeInfo.latitude),
        longitude: double.parse(earthquakeInfo.longitude),
      ),
    );
  }
}
class DifferentPlaces {
  void navigate(BuildContext context, EarthquakeInfo earthquakeInfo) {
    NavigationHelper.navigateToDifferentPlaces(context, earthquakeInfo);
  }
}
