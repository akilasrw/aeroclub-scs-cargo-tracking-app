import 'package:json_annotation/json_annotation.dart';

part 'flight.g.dart';

@JsonSerializable()
class Flight {
  String id;
  String value;

  Flight(this.id,
      this.value);

  factory Flight.fromJson(Map<String, dynamic> json) =>
      _$FlightFromJson(json);

  Map<String, dynamic> toJson() => _$FlightToJson(this);
}