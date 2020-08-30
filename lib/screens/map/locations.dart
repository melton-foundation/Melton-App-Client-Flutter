import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/services.dart' show rootBundle;

part 'locations.g.dart';

@JsonSerializable()
class LatLng {
  LatLng({
    this.lat,
    this.lng,
  });

  factory LatLng.fromJson(Map<String, dynamic> json) => _$LatLngFromJson(json);
  Map<String, dynamic> toJson() => _$LatLngToJson(this);

  final double lat;
  final double lng;
}

@JsonSerializable()
class Office {
  Office({
    this.country,
    this.lat,
    this.lng,
    this.name,
  });

  factory Office.fromJson(Map<String, dynamic> json) => _$OfficeFromJson(json);
  Map<String, dynamic> toJson() => _$OfficeToJson(this);

  final String country;
  final double lat;
  final double lng;
  final String name;
}

@JsonSerializable()
class Locations {
  Locations({
    this.offices,
  });

  factory Locations.fromJson(Map<String, dynamic> json) =>
      _$LocationsFromJson(json);
  Map<String, dynamic> toJson() => _$LocationsToJson(this);

  final List<Office> offices;
}

//To import from Local Folder
// Future<String> _loadAStudentAsset() async {
//   return await rootBundle.loadString('assets/short.json');
// }

// Future<Locations> loadStudent() async {
//   String jsonString = await _loadAStudentAsset();
//   final jsonResponse = json.decode(jsonString);
//   return new Locations.fromJson(jsonResponse);
// }

Future<Locations> meltonpeeps() async {
  const locationsURL = 'http://arunjoseph19.github.io/leaf/short.json';
  //add ur github json file here

  // Retrieve the locations
  final response = await http.get(locationsURL);
  if (response.statusCode == 200) {
    return Locations.fromJson(json.decode(response.body));
  } else {
    throw HttpException(
        'Unexpected status code ${response.statusCode}:'
        ' ${response.reasonPhrase}',
        uri: Uri.parse(locationsURL));
  }
}
