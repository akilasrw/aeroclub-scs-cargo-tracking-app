import 'package:flutter/material.dart';

class BaseProvider extends ChangeNotifier {
  bool isLoading = false;
  String? error;
  void setLoading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  void setError(String? errorMessage) {
    isLoading = false;
    error = errorMessage;
    notifyListeners();
  }
}
