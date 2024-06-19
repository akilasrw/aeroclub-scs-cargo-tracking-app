import 'package:json_annotation/json_annotation.dart';

part 'sector.g.dart';

@JsonSerializable()
class Sector {
  String originId;
  String originName;
  String originCode;
  String destinationId;
  String destinationName;
  String destinationCode;

  Sector(this.originId,
      this.originName,
      this.originCode,
      this.destinationId,
      this.destinationName,
      this.destinationCode);

  factory Sector.fromJson(Map<String, dynamic> json) =>
      _$SectorFromJson(json);

  Map<String, dynamic> toJson() => _$SectorToJson(this);
}