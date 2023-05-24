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
          color: Colors.white,
          child: ListTile(
            title: Text(earthquakeInfo.location,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                    fontWeight: FontWeight.bold)),
            subtitle: Row(
              children: [
                Text(
                  'Magnitude: ${earthquakeInfo.ml}',
                  style: TextStyle(
                       fontSize: 15,
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                Text(
                  ' || ',
                  style: TextStyle(color: Colors.black),
                ),
                Text('Depth: ${earthquakeInfo.depth}',
                    style: TextStyle(
                      fontSize: 15,
                        fontWeight: FontWeight.bold, color: Colors.black)),
              ],
            ),
            trailing: IconButton(
              color: Colors.black,
              icon: Icon(Icons.map),
              onPressed: () =>
                  Navigator.of(context).pushNamed('/show-all-earthquakes'),
              tooltip: ('Show on Map'),
            ),
          ),
        ),
        Container(height: 2, color: Colors.black),
      ],
    );
  }
}
