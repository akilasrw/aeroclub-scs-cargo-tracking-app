import 'package:json_annotation/json_annotation.dart';

part 'uld_filter.g.dart';

@JsonSerializable()
class ULDFilter {
  String? uld;
  String? flightNum;
  String? flightDate;

  ULDFilter({this.uld,this.flightNum,this.flightDate});

  factory ULDFilter.fromJson(Map<String, dynamic> json) =>
      _$ULDFilterFromJson(json);

  Map<String, dynamic> toJson() => _$ULDFilterToJson(this);
}