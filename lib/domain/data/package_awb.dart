import 'package:json_annotation/json_annotation.dart';

part 'package_awb.g.dart';

@JsonSerializable()
class PackageAWB {
  String packageRef;
  int awbNum;

  PackageAWB({required this.packageRef,
    required this.awbNum});

  factory PackageAWB.fromJson(Map<String, dynamic> json) =>
      _$PackageAWBFromJson(json);

  Map<String, dynamic> toJson() => _$PackageAWBToJson(this);
}