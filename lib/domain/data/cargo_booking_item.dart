import 'package:json_annotation/json_annotation.dart';

part 'cargo_booking_item.g.dart';

@JsonSerializable()
class CargoBookingItem {
  int packageItemStatus;
  String packageRefNumber;

  CargoBookingItem({required this.packageItemStatus, required this.packageRefNumber});



  factory CargoBookingItem.fromJson(Map<String, dynamic> json) =>
      _$CargoBookingItemFromJson(json);

  Map<String, dynamic> toJson() => _$CargoBookingItemToJson(this);
}