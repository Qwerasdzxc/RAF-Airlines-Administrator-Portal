import 'package:flutter/material.dart';

class Dialogs {
  static void showConfirmationDialog(
      {required BuildContext context, required String content, required VoidCallback callback}) {
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () => Navigator.pop(context),
    );

    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed: () {
        callback();
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Row(
        children: [
          Icon(
            Icons.warning,
            color: Colors.red,
          ),
          SizedBox(
            width: 12,
          ),
          Text(
            "Confirmation",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      content: Text(content),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(context: context, builder: (_) => alert);
  }
}
