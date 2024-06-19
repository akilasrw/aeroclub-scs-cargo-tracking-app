import 'package:Cargo_Tracker/domain/data/sector.dart';
import 'package:json_annotation/json_annotation.dart';

part 'flight.g.dart';

@JsonSerializable()
class Flight {
  String flightId;
  String flightNumber;
  String originCode;
  String destinationCode;
  List<Sector> sectors;

  Flight(this.flightId,
      this.flightNumber,
      this.originCode,
      this.destinationCode,
      this.sectors);

  factory Flight.fromJson(Map<String, dynamic> json) =>
      _$FlightFromJson(json);

  Map<String, dynamic> toJson() => _$FlightToJson(this);
}