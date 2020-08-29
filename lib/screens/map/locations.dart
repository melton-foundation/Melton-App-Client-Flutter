import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

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

// @JsonSerializable()
// class Region {
//   Region({
//     this.coords,
//     this.id,
//     this.name,
//     this.zoom,
//   });

//   factory Region.fromJson(Map<String, dynamic> json) => _$RegionFromJson(json);
//   Map<String, dynamic> toJson() => _$RegionToJson(this);

//   final LatLng coords;
//   final String id;
//   final String name;
//   final double zoom;
// }

@JsonSerializable()
class Office {
  Office({
    this.country,
    //  this.id,
    //  this.image,
    this.lat,
    this.lng,
    this.name,
    //  this.phone,
    //  this.region,
  });

  factory Office.fromJson(Map<String, dynamic> json) => _$OfficeFromJson(json);
  Map<String, dynamic> toJson() => _$OfficeToJson(this);

  final String country;
  // final String id;
  // final String image;
  final double lat;
  final double lng;
  final String name;
  // final String phone;
  // final String region;
}

@JsonSerializable()
class Locations {
  Locations({
    this.offices,
    //  this.regions,
  });

  factory Locations.fromJson(Map<String, dynamic> json) =>
      _$LocationsFromJson(json);
  Map<String, dynamic> toJson() => _$LocationsToJson(this);

  final List<Office> offices;
  //final List<Region> regions;
}

// JsonDecoder LOC() async {
//   const loc = 'http://www.mapquestapi.com/geocoding/v1/address?key=FCiBSq5dYIEcxsIkDFHHeU4pdxl2KalZ&location=Bangalore';
//   //add ur github json file here

//   // Retrieve the locations of Google offices
//   final response = await http.get(loc);
//   if (response.statusCode == 200) {
//     return (json.decode(response.body));
//   } else {
//     throw HttpException(
//         'Unexpected status code ${response.statusCode}:'
//         ' ${response.reasonPhrase}',
//         uri: Uri.parse(loc));
//   }
// }

Future<Locations> meltonpeeps() async {
  const locationsURL = 'http://arunjoseph19.github.io/leaf/short.json';
  //const locationsURL = 'https://arunjoseph19.github.io/leaf/chumma.json';
  //add ur github json file here

  // Retrieve the locations of Google offices
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
