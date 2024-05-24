import 'package:json_annotation/json_annotation.dart';

part 'package_filter_req.g.dart';

@JsonSerializable()
class PackageFilterReq {
  int? awbNumber;
  bool? includeCargoBooking;
  List<int>? packageItemStatuses;
  String? uld;

  PackageFilterReq({this.awbNumber,
    this.includeCargoBooking,
  this.packageItemStatuses,
  this.uld});

  factory PackageFilterReq.fromJson(Map<String, dynamic> json) =>
      _$PackageFilterReqFromJson(json);

  Map<String, dynamic> toJson() => _$PackageFilterReqToJson(this);
}