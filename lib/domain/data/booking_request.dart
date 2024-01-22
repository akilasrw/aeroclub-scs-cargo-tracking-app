// import 'package:Cargo_Tracker/domain/data/cargo_booking_item.dart';
// import 'package:json_annotation/json_annotation.dart';
//
// part 'booking.g.dart';
//
// @JsonSerializable()
// class Booking {
//
//   int bookingStatus;
//
//   String? destinationAirportId;
//
//
//
//
//   String truckNo;
//   String? cargoAgent;
//   String? origin;
//   String? destination;
//   int? awbTrackingNumber;
//   List<CargoBookingItem>? packages;
//
//   Booking({
//     required this.awbTrackingNumber,
//     required this.bookingStatus,
//     this.originAirportId,
//     this.destinationAirportId,
//     this.truckNo,
//     this.packageItems,
//     this.cargoAgent,
//   });
//
//   factory Booking.fromJson(Map<String, dynamic> json) =>
//       _$BookingFromJson(json);
//
//   Map<String, dynamic> toJson() => _$BookingToJson(this);
//
// // factory Booking.fromMap(Map<String, dynamic> json) {
// //   return Booking(
// //       json['bookingNumber'],
// //       json['bookingStatus'],
// //       json['originAirportId'],
// //       json['destinationAirportId'],
// //       json['truckNo'],
// //       json['orderItems']
// //   );
// // }
// }
