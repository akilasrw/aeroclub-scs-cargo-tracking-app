import 'enum.dart';

class ResultStatus<int> extends Enum<int> {
  const ResultStatus(int val) : super(val);
  static const None = const ResultStatus(0);
  static const LoginSuccess = const ResultStatus(1);
  static const LoginFailed = const ResultStatus(2);
  static const LoginExpired = ResultStatus(3);
  static const AllOK = const ResultStatus(200);
  static const AlreadyExists = const ResultStatus(201);
  static const InternalError = const ResultStatus(500);
  static const InvalidRequest = const ResultStatus(-999);
}