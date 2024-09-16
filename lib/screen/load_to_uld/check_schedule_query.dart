import 'package:json_annotation/json_annotation.dart';

part 'check_schedule_query.g.dart';

@JsonSerializable()
class CheckScheduleQuery {
  String? date;
  String? flightNum;

  CheckScheduleQuery({this.date,this.flightNum});

  factory CheckScheduleQuery.fromJson(Map<String, dynamic> json) =>
      _$CheckScheduleQueryFromJson(json);

  Map<String, dynamic> toJson() => _$CheckScheduleQueryToJson(this);
}