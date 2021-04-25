import 'package:flutter/material.dart';
import 'package:platform_alert_dialog/platform_alert_dialog.dart';

class DialogUtils {

  showDialogMessage(BuildContext context, String title, String message){
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return PlatformAlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            PlatformDialogAction(
              child: Text('ปิด'),
              actionType: ActionType.Preferred,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  showDialogYesNo(BuildContext context, String title, String message, Function function){
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return PlatformAlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            PlatformDialogAction(
              child: Text('ใช่'),
              actionType: ActionType.Preferred,
              onPressed: () {
                function(context);
                Navigator.of(context).pop();
              },
            ),
            PlatformDialogAction(
              child: Text('ไม่ใช่'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}