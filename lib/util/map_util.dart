import "dart:math";

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:melton_app/util/world_cities.dart';
import 'package:melton_app/constants/constants.dart';

class MapUtil {
  static const MAP_STYLE_PATH = "assets/maps/maps_style.json";
  static const MELTON_WORLD_MAP_PATH = "assets/maps/world_map_with_melton_cities.png";

  static final _random = new Random();

  static LatLng getLatLngForCity(String city) {
    if (!WorldCities.WORLD_CITIES.containsKey(city)) {
      return LatLng(12.9, 77.7);
    }
    double lat = WorldCities.WORLD_CITIES[city][0];
    double lng = WorldCities.WORLD_CITIES[city][1];
    return LatLng(lat, lng);
  }

  static LatLng getLatLngForRandomMeltonCity() {
    String randomCity = Constants.meltonCities[_random.nextInt(Constants.meltonCities.length)];
    return getLatLngForCity(randomCity);
  }

}