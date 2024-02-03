import 'package:json_annotation/json_annotation.dart';

part 'package_filter_req.g.dart';

@JsonSerializable()
class PackageFilterReq {
  int awbNumber;
  bool includeCargoBooking;

  PackageFilterReq({required this.awbNumber,
    required this.includeCargoBooking});

  factory PackageFilterReq.fromJson(Map<String, dynamic> json) =>
      _$PackageFilterReqFromJson(json);

  Map<String, dynamic> toJson() => _$PackageFilterReqToJson(this);
}