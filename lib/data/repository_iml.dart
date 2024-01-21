import 'package:Cargo_Tracker/data/local/local_storage.dart';
import 'package:Cargo_Tracker/data/remote/rest_api.dart';
import 'package:Cargo_Tracker/domain/data/login_request.dart';
import 'package:Cargo_Tracker/domain/data/login_response.dart';
import 'package:Cargo_Tracker/domain/repository/repository.dart';
import 'package:Cargo_Tracker/router/router.dart';
import 'package:Cargo_Tracker/router/router.gr.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

class RepositoryImpl implements Repository {
  static final RepositoryImpl repository = RepositoryImpl._internal();

  RepositoryImpl._internal();

  static Dio dio = Dio(baseOptions);

  static BaseOptions baseOptions = BaseOptions(
    responseType: ResponseType.json,
    connectTimeout: const Duration(milliseconds: 300000),
    receiveTimeout: const Duration(milliseconds: 300000),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json'
    },
  );

  static RestClient? _restClient;
  static RestClient? _tokenRefreshRestClient;
  static LocalStorage? _localStorage;
  static String? _baseURL;

  factory RepositoryImpl({required String baseURL}) {
    _baseURL = baseURL;
    _tokenRefreshRestClient = RestClient(Dio(baseOptions), baseUrl: baseURL);
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        var token = await _localStorage!.getAuthToken();
        if (token != null) {
          if (kDebugMode) {
            print('token $token');
          }
          options.headers["Authorization"] = "Bearer " + token;
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (DioError error, handler) async {
        if (error.response != null) {
          var router = GetIt.I<AppRouter>();
          try {
            if (error.response?.statusCode == 401 ||
                error.response?.statusCode == 403) {
              var options = error.response?.requestOptions;
              var _token = await _localStorage!.getAuthToken();
              var _refreshToken = await _localStorage!.getRefreshToken();
              var updatedToken = await _tokenRefreshRestClient!.refreshToken(_refreshToken!);
              if (updatedToken.jwtToken != null && updatedToken.jwtToken!.isNotEmpty) {
                options?.headers["Authorization"] =
                "Bearer ${updatedToken.jwtToken}";
                var result = await _localStorage!.saveToken(updatedToken);
                if (kDebugMode) {
                  print('refresh token $_refreshToken');
                  print('old token $_token');
                  print(
                      'updated token ${updatedToken.jwtToken} token updated !');
                }
              } else {
                router.navigate(const LoginRoute());
              }

              final opts = Options(
                  method: options?.method,
                  headers: options?.headers,
                  sendTimeout: options?.sendTimeout,
                  receiveTimeout: options?.receiveTimeout,
                  extra: options?.extra,
                  responseType: options?.responseType,
                  contentType: options?.contentType,
                  validateStatus: options?.validateStatus,
                  receiveDataWhenStatusError:
                  options?.receiveDataWhenStatusError,
                  followRedirects: options?.followRedirects,
                  maxRedirects: options?.maxRedirects,
                  requestEncoder: options?.requestEncoder,
                  responseDecoder: options?.responseDecoder,
                  listFormat: options?.listFormat);
              var dio = Dio(baseOptions);
              final cloneReq = await dio.request(
                '${options?.baseUrl}${options!.path}',
                options: opts,
                data: options.data,
                queryParameters: options.queryParameters,
              );
              return handler.resolve(cloneReq);
            } else {
              return handler.next(error);
            }
          } catch (e) {
            if (kDebugMode) {
              print(e);
            }
            await _localStorage?.logOutUser();
            router.navigate(const LoginRoute());
          }
        } else {
          return handler.next(error);
        }
      },
    ));
    _localStorage = LocalStorage();
    _restClient = RestClient(dio, baseUrl: baseURL);
    return repository;
  }

  @override
  Future<LoginResponse> loginUser(LoginRequest loginRequest) {
    return _restClient!.loginUser(loginRequest);
  }

  @override
  Future<String?> getAuthToken() {
    return _localStorage!.getAuthToken();
  }

  @override
  Future<String?> getRefreshToken() {
    return _localStorage!.getRefreshToken();
  }

  @override
  Future<bool> logOutUser() {
    return _localStorage!.logOutUser();
  }

  @override
  Future<void> saveToken(LoginResponse tokenData) {
    return _localStorage!.saveToken(tokenData);
  }


}
