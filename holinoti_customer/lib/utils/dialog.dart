import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:holinoti_customer/constants/strings.dart' as Strings;

class AppDialog {
  static final AppDialog _instance = AppDialog._();
  BuildContext _context;

  AppDialog._();

  factory AppDialog(BuildContext context) {
    _instance._context = context;
    return _instance;
  }

  Future showConfirmDialog(String message, {void onConfirm()}) async =>
      showPlatformDialog(
        context: _context,
        builder: (BuildContext context) => WillPopScope(
          onWillPop: () async => _onWillPop(onConfirm),
          child: PlatformAlertDialog(
            title: Text(Strings.GlobalPage.ALERT_TITLE),
            content: Text(message),
            actions: <Widget>[
              PlatformButton(
                androidFlat: (BuildContext context) => MaterialFlatButtonData(
                  child: Text(Strings.GlobalPage.BUTTON_CONFIRM),
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (onConfirm != null) onConfirm();
                  },
                ),
                ios: (BuildContext context) => CupertinoButtonData(
                  child: Text(Strings.GlobalPage.BUTTON_CONFIRM),
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (onConfirm != null) onConfirm();
                  },
                ),
              ),
            ],
          ),
        ),
      );

  Future showYesNoDialog(String message, {void onConfirm(), void onCancel()}) =>
      showPlatformDialog(
        context: _context,
        builder: (BuildContext context) => WillPopScope(
          onWillPop: () async => _onWillPop(onCancel),
          child: PlatformAlertDialog(
            title: Text(Strings.GlobalPage.ALERT_TITLE),
            content: Text(message),
            actions: <Widget>[
              PlatformButton(
                androidFlat: (BuildContext context) => MaterialFlatButtonData(
                  child: Text(Strings.GlobalPage.BUTTON_YES),
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (onConfirm != null) onConfirm();
                  },
                ),
                ios: (BuildContext context) => CupertinoButtonData(
                  child: Text(Strings.GlobalPage.BUTTON_YES),
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (onConfirm != null) onConfirm();
                  },
                ),
              ),
              PlatformButton(
                androidFlat: (BuildContext context) => MaterialFlatButtonData(
                  child: Text(Strings.GlobalPage.BUTTON_NO),
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (onCancel != null) onCancel();
                  },
                ),
                ios: (BuildContext context) => CupertinoButtonData(
                  child: Text(Strings.GlobalPage.BUTTON_NO),
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (onCancel != null) onCancel();
                  },
                ),
              ),
            ],
          ),
        ),
      );

  Future showInputDialog(
      {String title = Strings.GlobalPage.ALERT_INPUT,
      String message,
      String text = '',
      String hint,
      bool isObscureText = false,
      List<TextInputFormatter> inputFormatters,
      Function onConfirm,
      Function onCancel()}) async {
    TextEditingController controller = TextEditingController();
    controller.text = text;

    onSubmit([String text]) {
      Navigator.of(_context).pop();
      if (onConfirm != null) onConfirm(controller.value.text);
    }

    return showPlatformDialog(
      context: _context,
      builder: (final BuildContext context) => AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            message == null ? Container() : Text(message),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: hint,
                ),
                inputFormatters: inputFormatters,
                autofocus: true,
                onSubmitted: onSubmit,
                obscureText: isObscureText,
              ),
            )
          ],
        ),
        actions: <Widget>[
          PlatformButton(
            androidFlat: (BuildContext context) => MaterialFlatButtonData(
              child: Text(Strings.GlobalPage.BUTTON_SUBMIT),
              onPressed: onSubmit,
            ),
            ios: (BuildContext context) => CupertinoButtonData(
              child: Text(Strings.GlobalPage.BUTTON_SUBMIT),
              onPressed: onSubmit,
            ),
          ),
          PlatformButton(
            androidFlat: (BuildContext context) => MaterialFlatButtonData(
              child: Text(Strings.GlobalPage.BUTTON_CANCEL),
              onPressed: () {
                Navigator.of(context).pop();
                if (onCancel != null) onCancel();
              },
            ),
            ios: (BuildContext context) => CupertinoButtonData(
              child: Text(Strings.GlobalPage.BUTTON_CANCEL),
              onPressed: () {
                Navigator.of(context).pop();
                if (onCancel != null) onCancel();
              },
            ),
          ),
        ],
      ),
    );
  }

  Future showSelectCasesDialog(final String title,
          {Map<String, void Function()> cases}) =>
      showPlatformDialog(
        context: _context,
        builder: (final BuildContext context) => PlatformAlertDialog(
          title: Text(title),
          actions: cases
              .map(
                (msg, f) => MapEntry(
                  msg,
                  PlatformDialogAction(
                    onPressed: () {
                      Navigator.of(context).pop();
                      f();
                    },
                    child: Text(msg),
                  ),
                ),
              )
              .values
              .toList(),
        ),
      );

  Future<bool> _onWillPop(void onDismiss()) async {
    if (onDismiss != null) onDismiss();
    return true;
  }
}
