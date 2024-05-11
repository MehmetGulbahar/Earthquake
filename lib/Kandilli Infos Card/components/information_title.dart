import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/earthquake_info.dart';

class InformationTitle extends StatelessWidget {
  const InformationTitle({
    super.key,
    required this.earthquakeInfo,
  });

  final EarthquakeInfo earthquakeInfo;

  @override
  Widget build(BuildContext context) {
    return Text(
      earthquakeInfo.location,
      style: GoogleFonts.openSans(
          fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
    );
  }
}
