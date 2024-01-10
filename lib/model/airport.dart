import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Airport {
  String id;
  String value;

  Airport(this.id,
    this.value);

  factory Airport.fromMap(Map<String, dynamic> json) {
    return Airport(
      json['id'],
      json['value']
    );
  }
}