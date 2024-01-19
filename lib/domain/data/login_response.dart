import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  String? jwtToken;
  String? refreshToken;
  String? id;
  String? firstName;
  String? lastName;
  String? username;

  LoginResponse(
      {this.jwtToken,
      this.refreshToken,
      this.username,
      this.firstName,
      this.lastName,
      this.id});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
