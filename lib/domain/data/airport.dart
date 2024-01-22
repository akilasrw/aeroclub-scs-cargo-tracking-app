import 'package:json_annotation/json_annotation.dart';

part 'airport.g.dart';

@JsonSerializable()
class Airport {
  String id;
  String value;

  Airport({required this.id,required this.value});

  factory Airport.fromJson(Map<String, dynamic> json) =>
      _$AirportFromJson(json);
  Map<String, dynamic> toJson() => _$AirportToJson(this);
}