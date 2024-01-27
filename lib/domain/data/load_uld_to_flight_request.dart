import 'package:json_annotation/json_annotation.dart';

part 'load_uld_to_flight_request.g.dart';

@JsonSerializable()
class LoadULDtoFlightRequest {

  bool? isArrived;
  List<String>? ulds;

  LoadULDtoFlightRequest({
    required this.isArrived,
    required this.ulds
  });

  factory LoadULDtoFlightRequest.fromJson(Map<String, dynamic> json) =>
      _$LoadULDtoFlightRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoadULDtoFlightRequestToJson(this);

}
