import 'package:json_annotation/json_annotation.dart';

part 'awb_filter.g.dart';

@JsonSerializable()
class AWBFilter {
  int? awbTrackingNum;

  AWBFilter({this.awbTrackingNum});

  factory AWBFilter.fromJson(Map<String, dynamic> json) =>
      _$AWBFilterFromJson(json);

  Map<String, dynamic> toJson() => _$AWBFilterToJson(this);
}