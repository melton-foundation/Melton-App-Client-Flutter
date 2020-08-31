class Tag {
  double lat;
  double lng;

  Tag(this.lat, this.lng);

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(json['lat'] as double, json['lng'] as double);
  }

  String toDouble() {
    return '{ ${this.lat}, ${this.lng} }';
  }
}
