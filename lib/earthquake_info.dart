import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
class EarthquakeInfo {
  final String date;
  final String time;
  final String latitude;
  final String longitude;
  final String depth;
  final String md;
  final String ml;
  final String mw;
  final String location;
  final String quality;

  EarthquakeInfo({
    required this.date,
    required this.time,
    required this.latitude,
    required this.longitude,
    required this.depth,
    required this.md,
    required this.ml,
    required this.mw,
    required this.location,
    required this.quality,
  });

  factory EarthquakeInfo.fromJson(Map json) {
    return EarthquakeInfo(
    date:  json['date'],
    time:  json['time'],
    latitude:  json['latitude'],
    longitude:  json['longitude'],
    depth:  json['depth'],
    md:  json['md'],
    ml:  json['ml'],
    mw:  json['mw'],
    location:  json['location'],
    quality:  json['quality'],
    );
  }

}


Future<String> earthquakeDataToJson() async {
  var url = 'http://www.koeri.boun.edu.tr/scripts/lst8.asp';

  HttpClient httpClient = new HttpClient();
  HttpClientRequest request = await httpClient.getUrl(Uri.parse(url));
  HttpClientResponse response = await request.close();

  var responseBody = await response.transform(latin1.decoder).join();

  var document = parse(responseBody);
  var preElement = document.querySelector('body > pre');

  var rawLines = preElement!.text.split('\n').sublist(6);

  List<Map<String, dynamic>> earthquakes = [];

  for(var line in rawLines) {
    var segments = line.split(RegExp('\\s+'));

    if (segments.length < 9) continue;
    var locationSplitIndex = segments.length -1;

    Map<String, dynamic> earthquake = {
      'date': segments[0],
      'time': segments[1],
      'latitude': segments[2],
      'longitude': segments[3],
      'depth': segments[4],
      'md': segments[5],
      'ml': segments[6],
      'mw': segments[7],
      'location': segments.sublist(8, locationSplitIndex).join(' '),
      'quality': segments[segments.length - 1],
    };

    earthquakes.add(earthquake);
  }

  String jsonStr = jsonEncode(earthquakes, toEncodable: (item) {
    if(item is Map<String, dynamic>) {
      return item.map((key, value) => MapEntry(key, value.toString()));
    }
    return item.toString();
  });

  // Türkçe karakterler için düzeltmeler
  jsonStr = jsonStr.replaceAll('Ý', 'İ').replaceAll('Ð', 'Ğ').replaceAll('Þ', 'Ş').replaceAll('þ', 'ş').replaceAll('ð', 'ğ').replaceAll('ý', 'ı');

  // çıktıyı utf8 formatına dönüştür
  var encodedJson = utf8.encode(jsonStr);
  return String.fromCharCodes(encodedJson);
}