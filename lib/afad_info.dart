import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';

class AfadInfo {
  final String tarih;
  final String enlem;
  final String boylam;
  final String derinlik;
  final String tip;
  final String buyukluk;
  final String yer;
  final String id;

  AfadInfo({
    this.tarih = '',
    this.enlem = '' ,
    this.boylam = '',
    this.derinlik = '',
    this.tip = '',
    this.buyukluk = '',
    this.yer = '',
    this.id = '',
  });

  factory AfadInfo.fromJson(Map<String, dynamic> json) {
    return AfadInfo(
        tarih: json['tarih'],
        enlem: json['enlem'],
        boylam: json['boylam'],
        derinlik: json['derinlik'],
        tip: json['tip'],
        buyukluk: json['buyukluk'],
        yer: json['yer'],
        id: json['id']
    );
  }

  Map<String, dynamic> toJson() => {
    'tarih': tarih,
    'enlem': enlem,
    'boylam': boylam,
    'derinlik': derinlik,
    'tip': tip,
    'buyukluk': buyukluk,
    'yer': yer,
    'id': id,
  };
}

Future<List<AfadInfo>> afadEarthquake() async {
  final response = await http.get(Uri.parse('https://deprem.afad.gov.tr/last-earthquakes.html'));
  Document document = parse(utf8.decode(response.bodyBytes));
  List<Element> tableRows = document.querySelectorAll('table tr');
  List<AfadInfo> earthquakes = [];

  for (var tr in tableRows) {
    List<Element> td = tr.querySelectorAll('td');
    if (td.isNotEmpty) {
      earthquakes.add(AfadInfo(
        tarih: td[0].text.trim(),
        enlem: td[1].text.trim(),
        boylam: td[2].text.trim(),
        derinlik: td[3].text.trim(),
        tip: td[4].text.trim(),
        buyukluk: td[5].text.trim(),
        yer: td[6].text.trim(),
        id: td[7].text.trim(),
      ));
    }
  }

  return earthquakes;
}

void main() async {
  List<AfadInfo> earthquakes = await afadEarthquake();
  earthquakes.forEach((earthquake) {
    print(jsonEncode(earthquake.toJson()));
  });
}