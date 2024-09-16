import 'package:json_annotation/json_annotation.dart';

part 'check_awb_qrery.g.dart';

@JsonSerializable()
class CheckAWBQuery {
  int? awb;
  String? agentId;

  CheckAWBQuery({this.awb,this.agentId});

  factory CheckAWBQuery.fromJson(Map<String, dynamic> json) =>
      _$CheckAWBQueryFromJson(json);

  Map<String, dynamic> toJson() => _$CheckAWBQueryToJson(this);
}