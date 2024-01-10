import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CargoBookingItem {
  int packageItemStatus;
  String packageRefNumber;

  CargoBookingItem(this.packageItemStatus,
      this.packageRefNumber);

  factory CargoBookingItem.fromMap(Map<String, dynamic> json) {
    return CargoBookingItem(
        json['packageItemStatus'],
        json['packageRefNumber']
    );
  }
}