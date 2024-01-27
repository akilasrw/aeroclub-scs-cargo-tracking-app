import 'package:json_annotation/json_annotation.dart';

part 'uld.g.dart';

@JsonSerializable()
class ULD {
  String id;
  String serialNumber;

  ULD({required this.id,
      required this.serialNumber});

  factory ULD.fromJson(Map<String, dynamic> json) =>
      _$ULDFromJson(json);

  Map<String, dynamic> toJson() => _$ULDToJson(this);
}