import 'package:Cargo_Tracker/screen/app/theme.dart';
import 'package:flutter/material.dart';

class MessageService {
  final List<Alert> alertQueue = <Alert>[];

  /// Flush the queue of alerts, showing all in sequence (FIFO)
  void flushQueue(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      while (alertQueue.isNotEmpty) {
        _showAlert(context, alertQueue.removeAt(0));
      }
    });
  }

  /// Show a snackbar alert in the warning colour
  void messageAlert(
    BuildContext? context,
    String Function(BuildContext) content, {
    String? buttonText,
    void Function()? onButtonPress,
    bool queue = false,
    Duration duration = const Duration(seconds: 4),
  }) {
    final Alert alert = Alert(content,
        buttonText: buttonText,
        backgroundColor: AppTheme.primaryColour,
        onButtonPress: onButtonPress,
        duration: duration);

    if (queue || context == null) {
      alertQueue.add(alert);
    } else {
      _showAlert(context, alert);
    }
  }

  /// Show a snackbar alert in the danger colour
  ///
  /// This overrides the default ten second duration of the snackbar.
  void dangerAlert(
    BuildContext? context,
    String Function(BuildContext) content, {
    String? buttonText,
    void Function()? onButtonPress,
    bool queue = false,
  }) {
    final Alert alert = Alert(
      content,
      buttonText: buttonText,
      backgroundColor: AppTheme.errorTextColour,
      duration: const Duration(seconds: 20),
      onButtonPress: onButtonPress,
    );

    if (queue || context == null) {
      alertQueue.add(alert);
    } else {
      _showAlert(context, alert);
    }
  }

  void _showAlert(
    BuildContext context,
    Alert alert,
  ) {
    final ThemeData _theme = Theme.of(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: alert.backgroundColor,
      content: Text(
        alert.content(context),
        style: _theme.snackBarTheme.contentTextStyle,
      ),
      duration: alert.duration,
      action: alert.dismissable
          ? SnackBarAction(
              label: 'DISMISS',
              // label: (alert.buttonText ??
              //         GetIt.I<AppLocalizations>().translate(
              //           'defaultSnackBarButtonText',
              //           'DISMISS',
              //         ))
              // .toUpperCase(),
              textColor: _theme.snackBarTheme.actionTextColor,
              onPressed: () {
                if (alert.onButtonPress != null) {
                  alert.onButtonPress!();
                }

                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            )
          : null,
    ));
  }
}

class Alert {
  Alert(
    this.content, {
    this.backgroundColor,
    this.buttonText,
    this.onButtonPress,
    this.dismissable = true,
    this.duration = const Duration(seconds: 10),
  });

  final String Function(BuildContext) content;
  final Color? backgroundColor;
  final String? buttonText;
  final void Function()? onButtonPress;
  final bool dismissable;
  final Duration duration;
}
