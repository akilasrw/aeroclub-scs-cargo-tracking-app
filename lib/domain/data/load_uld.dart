import 'package:json_annotation/json_annotation.dart';

part 'load_uld.g.dart';

@JsonSerializable()
class LoadULD {

  String? flightID;
  String? scheduledDepartureDateTime;
  String? uldSerialNumber;
  String? uld;
  List<String>? packageIDs;

  LoadULD({
    required this.flightID,
    required this.scheduledDepartureDateTime,
    this.uldSerialNumber,
    required this.packageIDs,
    this.uld
  });

  factory LoadULD.fromJson(Map<String, dynamic> json) =>
      _$LoadULDFromJson(json);

  Map<String, dynamic> toJson() => _$LoadULDToJson(this);

}
