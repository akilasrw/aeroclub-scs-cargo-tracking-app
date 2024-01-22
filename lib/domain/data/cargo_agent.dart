import 'package:json_annotation/json_annotation.dart';

part 'cargo_agent.g.dart';


@JsonSerializable()
class CargoAgent {
  String appUserId;
  String agentName;

  CargoAgent({required this.appUserId,required this.agentName});

  factory CargoAgent.fromJson(Map<String, dynamic> json) =>
      _$CargoAgentFromJson(json);
  Map<String, dynamic> toJson() => _$CargoAgentToJson(this);
}