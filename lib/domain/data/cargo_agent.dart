import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CargoAgent {
  String appUserId;
  String agentName;

  CargoAgent(this.appUserId,
      this.agentName);

  factory CargoAgent.fromMap(Map<String, dynamic> json) {
    return CargoAgent(
        json['appUserId'],
        json['agentName']
    );
  }
}