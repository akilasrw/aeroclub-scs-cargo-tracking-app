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
  void showToast(BuildContext context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(label: message, onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}
