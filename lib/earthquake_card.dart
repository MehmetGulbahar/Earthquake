import 'package:earthquake_project/earthquake_info.dart';
import 'package:flutter/material.dart';

class EarthQuakeCard extends StatelessWidget {
  final EarthquakeInfo earthquakeInfo;

  const EarthQuakeCard({Key? key, required this.earthquakeInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100,
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
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
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  ),
                ),
              ),
            ),
            title: Text(earthquakeInfo.location,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Depth: ${earthquakeInfo.depth}',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                Text('Hour : ${earthquakeInfo.time}',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black))
              ],
            ),
            trailing: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.grey[200],
              ),
              child: IconButton(
                color: Colors.black,
                icon: Icon(Icons.arrow_forward_ios),
                onPressed:
                    () => Navigator.of(context).pushNamed('/show-all-earthquakes'),
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
