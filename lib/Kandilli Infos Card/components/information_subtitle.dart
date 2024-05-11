import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import '../models/earthquake_info.dart';

class InformationSubtitle extends StatelessWidget {
  const InformationSubtitle({
    Key? key,
    required this.earthquakeInfo,
  }) : super(key: key);

  final EarthquakeInfo earthquakeInfo;

  @override
  Widget build(BuildContext context) {
    List<String> timeParts = earthquakeInfo.time.split(':');

    String hour = timeParts[0];
    String minute = timeParts[1];

    String formattedTime = '$hour:$minute';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SubtitleRow(earthquakeInfo: earthquakeInfo),
        Row(
          children: [
            Icon(
              Icons.access_time_filled,
              color: HexColor("#00ADB5"),
              size: 18,
            ),
            Text(
              'Hour : $formattedTime',
              style: GoogleFonts.openSans(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ],
        )
      ],
    );
  }
}

class SubtitleRow extends StatelessWidget {
  const SubtitleRow({
    super.key,
    required this.earthquakeInfo,
  });

  final EarthquakeInfo earthquakeInfo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Row(
        children: [
          Icon(
            Icons.info_rounded,
            color: HexColor("#00ADB5"),
            size: 18,
          ),
          Text('Depth: ${earthquakeInfo.depth}',
              style: GoogleFonts.openSans(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
        ],
      ),
    );
  }
}
