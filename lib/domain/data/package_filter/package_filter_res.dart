import 'package:json_annotation/json_annotation.dart';

part 'package_filter_res.g.dart';

@JsonSerializable()
class PackageFilterRes {
  int packageRefNumber;

  PackageFilterRes({required this.packageRefNumber});

  factory PackageFilterRes.fromJson(Map<String, dynamic> json) =>
      _$PackageFilterResFromJson(json);

  Map<String, dynamic> toJson() => _$PackageFilterResToJson(this);
}