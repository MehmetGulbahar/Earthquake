import 'package:earthquake_project/Afad%20Cards%20Infos/AfadInfo.dart';
import 'package:earthquake_project/Afad%20Cards%20Infos/AfadInfo.dart';
import 'package:earthquake_project/Afad%20Cards%20Infos/AfadInfo.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'AfadInfo.dart';
import '../ScreenArguments/ScreenArguments.dart';


class AfadCard extends StatelessWidget {
  final InfoAfad InfosAfad;
  const AfadCard({Key? key, required this.InfosAfad }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String formattedDateTime = DateFormat('HH:mm:ss').format(DateTime.parse(InfosAfad.date)).toString();

    return Column(
      children: [
        Container(
          height: 110,
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.blue.shade700,
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            leading: SizedBox(
              width: 50,
              height: 50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: ColoredBox(
                  color: double.parse(InfosAfad.magnitude as String) > 4 ? Colors.red : Colors.grey,
                  child: Center(
                    child: Text(
                      '${InfosAfad.magnitude}',
                      style:GoogleFonts.openSans(fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            title: Text(InfosAfad.location,
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
                    Text('Depth: ${InfosAfad.depth}',
                        style: GoogleFonts.openSans(fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.access_time_filled,color: Colors.deepOrangeAccent,size: 18,),
                    Text(
                      'Hour: $formattedDateTime',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
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
                  depth:InfosAfad.depth,
                  ml: InfosAfad.magnitude,
                  place:InfosAfad.location,
                  latitude: double.parse(InfosAfad.latitude),
                  longitude:double.parse(InfosAfad.longitude),
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
