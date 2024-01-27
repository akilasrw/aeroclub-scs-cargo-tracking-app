import 'package:json_annotation/json_annotation.dart';

part 'cargo_booking_item.g.dart';

@JsonSerializable()
class CargoBookingItem {
  int status;
  String packageItemId;

  CargoBookingItem({required this.status, required this.packageItemId});



  factory CargoBookingItem.fromJson(Map<String, dynamic> json) =>
      _$CargoBookingItemFromJson(json);

  Map<String, dynamic> toJson() => _$CargoBookingItemToJson(this);
}