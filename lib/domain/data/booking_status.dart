import 'package:Cargo_Tracker/domain/data/cargo_booking_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'booking_status.g.dart';

@JsonSerializable()
class BookingStatus {

  String? truckNo;
  int? awbNumber;
  int? status;
  List<CargoBookingItem>? itemList;

  BookingStatus({
     this.truckNo,
     this.status,
     this.awbNumber,
    required this.itemList,
  });

  factory BookingStatus.fromJson(Map<String, dynamic> json) =>
      _$BookingStatusFromJson(json);

  Map<String, dynamic> toJson() => _$BookingStatusToJson(this);

}
