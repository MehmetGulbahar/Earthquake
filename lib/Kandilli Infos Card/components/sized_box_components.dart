import 'package:earthquake_project/Kandilli%20Infos%20Card/models/earthquake_info.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class SizedBoxComponents extends StatelessWidget {
  const SizedBoxComponents({
    super.key,
    required this.earthquakeInfo,
  });

  final EarthquakeInfo earthquakeInfo;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(3),
        child: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: ColoredBox(
            color: double.parse(earthquakeInfo.ml) > 4
                ? Colors.red
                : HexColor("#222831"),
            child: Center(
              child: Text(
                earthquakeInfo.ml,
                style: GoogleFonts.openSans(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
