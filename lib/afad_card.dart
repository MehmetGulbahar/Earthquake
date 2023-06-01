import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'ScreenArguments/ScreenArguments.dart';
import 'afad_info.dart';


class AfadCard extends StatelessWidget {
  final AfadInfo afadInfos;
  const AfadCard({Key? key, required this.afadInfos }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  color: double.parse(afadInfos.buyukluk) > 4 ? Colors.red : Colors.grey,
                  child: Center(
                    child: Text(
                      '${afadInfos.buyukluk}',
                      style:GoogleFonts.openSans(fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            title: Text(afadInfos.yer,
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
                    Text('Depth: ${afadInfos.derinlik}',
                        style: GoogleFonts.openSans(fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.access_time_filled,color: Colors.deepOrangeAccent,size: 18,),
                    Text('Hour : ${afadInfos.tarih}',
                      style:GoogleFonts.openSans(fontSize: 13,
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
                  depth:afadInfos.derinlik,
                  ml: afadInfos.buyukluk,
                  place:afadInfos.yer,
                  latitude: double.parse(afadInfos.enlem),
                  longitude:double.parse(afadInfos.boylam),
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
