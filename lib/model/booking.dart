import 'package:json_annotation/json_annotation.dart';
import 'package:Cargo_Tracker/model/cargo_booking_item.dart';

@JsonSerializable()
class Booking {
  String bookingNumber;
  int bookingStatus;
  String? originAirportId;
  String? destinationAirportId;
  String? truckNo;
  List<CargoBookingItem>? packageItems;

  Booking(this.bookingNumber,
      this.bookingStatus,
      this.originAirportId,
      this.destinationAirportId,
      this.truckNo,
      this.packageItems);

  factory Booking.fromMap(Map<String, dynamic> json) {
    return Booking(
        json['bookingNumber'],
        json['bookingStatus'],
        json['originAirportId'],
        json['destinationAirportId'],
        json['truckNo'],
        json['orderItems']
    );
  }
}