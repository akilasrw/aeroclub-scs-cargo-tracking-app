import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Flight {
  String id;
  String flightName;
  String? originAirportCode;
  String? destinationAirportCode;

  Flight(this.id,
      this.flightName,
      this.originAirportCode,
      this.destinationAirportCode);

  factory Flight.fromMap(Map<String, dynamic> json) {
    return Flight(
        json['id'],
        json['flightName'],
        json['originAirportCode'],
        json['destinationAirportCode']
    );
  }
}