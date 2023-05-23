import 'package:earthquake_project/earthquake_info.dart';
import 'package:flutter/material.dart';
class EarthQuakeCard extends StatelessWidget {
  final EarthquakeInfo earthquakeInfo;

  const EarthQuakeCard({Key? key, required this.earthquakeInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: ListTile(
        title: Text(earthquakeInfo.location,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        subtitle:
        Text('Magnitude: ${earthquakeInfo.ml} Depth: ${earthquakeInfo.depth}',style: TextStyle(fontWeight:FontWeight.bold ),),
        trailing: IconButton(
          color: Colors.red,
          icon: Icon(Icons.map),
          onPressed: () => Navigator.of(context).pushNamed('/show-all-earthquakes'),
          tooltip: ('Show on Map'),
        ),
      ),
    );
  }
}

