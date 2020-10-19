String validateCity(String city, String country) {
  return [city, country].where((string) => string.length != 0).join(", ");
}

bool isStringSpecified(String s) {
  return s != null && s.length > 0;
}
