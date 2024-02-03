import 'dart:convert';

import 'package:Cargo_Tracker/domain/data/jwt_response.dart';
import 'package:Cargo_Tracker/domain/data/login_request.dart';
import 'package:Cargo_Tracker/domain/repository/repository.dart';
import 'package:Cargo_Tracker/provider/base_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class LoginProviderProvider extends BaseProvider {
  late Repository repository;
  List<String> allowedUserRoles = ["Warehouse User","Super Admin","Warehouse Admin"];
  LoginProviderProvider() {
    repository = repository = GetIt.I<Repository>();
  }

  Future<bool> login(String userName,String password) async {
    try{
      setLoading(true);
     var response = await repository.loginUser(LoginRequest(username: userName, password: password));
      if(response.jwtToken != null) {
        if (kDebugMode) {
          print('token: ${response.refreshToken}');
        }

        String jwtToken = response.jwtToken!;
        final parts = jwtToken.split('.');
        final payload = parts[1];
        String normalizedSource = base64Url.normalize(payload);
        String obj =  utf8.decode(base64Url.decode(normalizedSource));
        final value = JWTResponse.fromJson(json.decode(obj));

        if(allowedUserRoles.contains(value.role)){
          await repository.saveInSharedPreferences("userName", response.username!);
          await repository.saveInSharedPreferences("userRole", value.role!);

          await repository.saveToken(response);
          setLoading(false);
          return Future.value(true);
        }
        else{
          setLoading(false);
          return Future.value(false);
        }

      }
    }catch(e){
      print(e);
      setLoading(false);
      return Future.value(false);
    }

    setLoading(false);
    return Future.value(false);
  }


}
