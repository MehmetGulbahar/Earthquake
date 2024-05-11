import 'package:earthquake_project/Kandilli%20Infos%20Card/components/sized_box_components.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/earthquake_info.dart';
import 'build_trailing.dart';
import 'information_subtitle.dart';
import 'information_title.dart';

class ListTitle extends StatelessWidget {
  const ListTitle({
    required this.earthquakeInfo,
  });

  final EarthquakeInfo earthquakeInfo;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBoxComponents(earthquakeInfo: earthquakeInfo),
      title: InformationTitle(earthquakeInfo: earthquakeInfo),
      subtitle: InformationSubtitle(earthquakeInfo: earthquakeInfo),
      trailing: BuildTrailing(earthquakeInfo: earthquakeInfo),
    );
  }
}
