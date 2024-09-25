import 'package:json_annotation/json_annotation.dart';

part 'package.g.dart';

@JsonSerializable()
class Package {

  String id;
  String packageRefNumber;
  String? dimension;
  double? width;
  double? height;
  double? length;
  double? weight;
  double? chargeableWeight;
  String? volumeUnitId;
  String? weightUnitId;
  int? declaredValue;
  int? packageItemStatus;
  String? description;
  int? packageItemType;
  String? uldContainerId;
  int? packagePriorityType;
  int? packageItemCategory;
  String? cargoBookingId;
  String? cargoPositionId;

  Package({
    required this.id,
    required this.packageRefNumber,
    this.dimension,
    this.width,
    this.height,
    this.length,
    this.weight,
    this.chargeableWeight,
    this.volumeUnitId,
    this.weightUnitId,
    this.declaredValue,
    this.packageItemStatus,
    this.description,
    this.packageItemType,
    this.uldContainerId,
    this.packagePriorityType,
    this.packageItemCategory,
    this.cargoBookingId,
    this.cargoPositionId,
  });

  factory Package.fromJson(Map<String, dynamic> json) =>
      _$PackageFromJson(json);

  Map<String, dynamic> toJson() => _$PackageToJson(this);

}
