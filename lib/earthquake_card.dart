

import 'package:earthquake_project/ScreenArguments/ScreenArguments.dart';
import 'package:earthquake_project/earthquake_info.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EarthQuakeCard extends StatelessWidget {
  final EarthquakeInfo earthquakeInfo;

  const EarthQuakeCard({Key? key, required this.earthquakeInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 110,
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            leading: SizedBox(
              width: 50,
              height: 50,
              child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ColoredBox(
                color: double.parse(earthquakeInfo.ml) > 4 ? Colors.red : Colors.grey,
                child: Center(
                  child: Text(
                    '${earthquakeInfo.ml}',
                    style:GoogleFonts.openSans(fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),

                  ),
                  ),
                ),
              ),
            ),
            title: Text(earthquakeInfo.location,
                style:GoogleFonts.openSans(fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                    ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.info_rounded,color: Colors.deepOrangeAccent,size: 18,),
                    Text('Depth: ${earthquakeInfo.depth}',
                        style: GoogleFonts.openSans(fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)
                            ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.access_time_filled,color: Colors.deepOrangeAccent,size: 18,),
                    Text('Hour : ${earthquakeInfo.time}',
                        style:GoogleFonts.openSans(fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),),
                  ],
                )
              ],
            ),
            trailing: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(70),
                color: Colors.grey[200],
              ),
              child: IconButton(
                color: Colors.black,
                icon: Icon(Icons.arrow_forward_ios),
                onPressed:
                    () => Navigator.of(context).pushNamed('/different-places-on-Turkey', arguments: ScreenArguments(
                        depth:earthquakeInfo.depth,
                        ml: earthquakeInfo.ml,
                      place:earthquakeInfo.location,
                      latitude: double.parse(earthquakeInfo.latitude),
                      longitude:double.parse(earthquakeInfo.longitude),
                    )),
                tooltip:
                ('Show on Map'),
              ),
            ),
          ),
        ),

      ],
    );

  }
}
