import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'components/list_tile.dart';
import 'models/earthquake_info.dart';

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
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          padding: const EdgeInsets.all(8),
          decoration: _customBoxDecoration(),
          child: ListTitle(earthquakeInfo: earthquakeInfo),
        ),
      ],
    );
  }

  BoxDecoration _customBoxDecoration() {
    return BoxDecoration(
      color: HexColor("#EEEEEE"),
    );
  }
}
