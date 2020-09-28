String validateCity(String city, String country) {
  return [city, country].where((string) => string.length != 0).join(", ");
}
