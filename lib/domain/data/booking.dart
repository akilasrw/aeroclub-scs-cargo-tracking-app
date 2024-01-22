import 'package:Cargo_Tracker/domain/data/cargo_booking_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'booking.g.dart';

@JsonSerializable()
class Booking {

  String truckNo;
  String? cargoAgent;
  String? origin;
  String? destination;
  String? awbTrackingNumber;
  List<CargoBookingItem>? packages;

  Booking({
    required this.truckNo,
    required this.cargoAgent,
    required this.origin,
    required this.destination,
    required this.awbTrackingNumber,
    required this.packages,
  });

  factory Booking.fromJson(Map<String, dynamic> json) =>
      _$BookingFromJson(json);

  Map<String, dynamic> toJson() => _$BookingToJson(this);

}
