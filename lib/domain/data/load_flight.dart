import 'package:json_annotation/json_annotation.dart';

part 'load_flight.g.dart';

@JsonSerializable()
class LoadFlight {

  String? flightID;
  String? scheduledDepartureDateTime;
  String? uldSerialNumber;
  List<String>? packageIDs;

  LoadFlight({
    required this.flightID,
    required this.scheduledDepartureDateTime,
    required this.uldSerialNumber,
    required this.packageIDs,
  });

  factory LoadFlight.fromJson(Map<String, dynamic> json) =>
      _$LoadFlightFromJson(json);

  Map<String, dynamic> toJson() => _$LoadFlightToJson(this);

}
