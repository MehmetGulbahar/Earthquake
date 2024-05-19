import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';

class InfoAfad {
  final String location;
  final String depth;
  final String magnitude;
  final String date;
  final String longitude;
  final String latitude;

  InfoAfad({
    this.location = '',
    this.depth = '',
    this.magnitude = '',
    this.date = '',
    this.longitude = '',
    this.latitude = '',
  });

  static fromJson(json) {}
}

Future<List<InfoAfad>> fetchEarthquakes() async {
  var minMag = "0"; // Min magnitude
  var maxMag = "20"; // Max magnitude
  var minDepth = "0"; // Min depth
  var maxDepth = "100"; // Max depth
  var now = DateTime.now();
  var fiveDaysAgo = now.subtract(const Duration(days: 2));
  var start =
      "${fiveDaysAgo.year}-${fiveDaysAgo.month.toString().padLeft(2, '0')}-${fiveDaysAgo.day.toString().padLeft(2, '0')}%2000:00:00";
  var end =
      "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}%2023:59:59";
  var url = Uri.parse(
      "https://deprem.afad.gov.tr/apiv2/event/filter?start=$start&end=$end&minmag=$minMag&maxmag=$maxMag&mindepth=$minDepth&maxdepth=$maxDepth");
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);

    for (var item in data) {
      var dateUtc = DateTime.parse(item['date']);
      var dateInTurkey = dateUtc.add(const Duration(hours: 3));
      item['date'] = dateInTurkey.toString();
    }
    var updatedData = data;

    List<InfoAfad> earthquakes = [];
    for (var earthquakeData in updatedData) {
      earthquakes.add(InfoAfad(
        location: earthquakeData['location'],
        depth: earthquakeData['depth'],
        magnitude: earthquakeData['magnitude'],
        date: earthquakeData['date'],
        latitude: earthquakeData['latitude'],
        longitude: earthquakeData['longitude'],
      ));
    }
    return earthquakes.reversed.toList();
  } else {
    print('Request failed with status: ${response.statusCode}.');
    return [];
  }
}
