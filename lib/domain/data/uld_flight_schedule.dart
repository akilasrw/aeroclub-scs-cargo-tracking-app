import 'package:json_annotation/json_annotation.dart';

part 'uld_flight_schedule.g.dart';

@JsonSerializable()
class ULDFlightSchedule {
  String flightNumber;
  String scheduledDepartureDateTime;

  ULDFlightSchedule({required this.flightNumber,
    required this.scheduledDepartureDateTime});

  factory ULDFlightSchedule.fromJson(Map<String, dynamic> json) =>
      _$ULDFlightScheduleFromJson(json);

  Map<String, dynamic> toJson() => _$ULDFlightScheduleToJson(this);
}