import 'package:Cargo_Tracker/domain/data/login_request.dart';
import 'package:Cargo_Tracker/domain/repository/repository.dart';
import 'package:Cargo_Tracker/provider/base_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class LoginProviderProvider extends BaseProvider {
  late Repository repository;
  LoginProviderProvider() {
    repository = repository = GetIt.I<Repository>();
  }

  Future<bool> login(String userName,String password) async {
    try{
     var response = await repository.loginUser(LoginRequest(username: userName, password: password));
      if(response.jwtToken != null) {
        if (kDebugMode) {
          print('token: ${response.refreshToken}');
        }
        await repository.saveToken(response);
        return Future.value(true);
      }
    }catch(e){
      print(e);
    }
    return Future.value(false);
  }


}
