import 'package:json_annotation/json_annotation.dart';

part 'uld.g.dart';

@JsonSerializable()
class ULD {
  String id;
  String serialNumber;
  int status;

  ULD({required this.id,
      required this.serialNumber,
      required this.status});

  factory ULD.fromJson(Map<String, dynamic> json) =>
      _$ULDFromJson(json);

  Map<String, dynamic> toJson() => _$ULDToJson(this);
}