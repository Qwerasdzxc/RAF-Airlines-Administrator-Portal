import 'package:flutter/material.dart';

enum AlertType { error, success, warning }

class Alert extends StatelessWidget {
  final AlertType type;
  final String text;

  const Alert({Key? key, required this.type, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: _bgColorForType(), borderRadius: BorderRadius.all(Radius.circular(6))),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Text(
              text,
              style:
                  TextStyle(fontSize: 20, color: _textColorForType()),
            )
          ],
        ),
      ),
    );
  }

  Color? _bgColorForType() {
    switch (type) {
      case AlertType.error:
        return Colors.redAccent[100];
      case AlertType.success:
        return Colors.green[200];
      case AlertType.warning:
        return Colors.orange[200];
    }

    return Colors.white;
  }

  Color? _textColorForType() {
    switch (type) {
      case AlertType.error:
        return Colors.red[800];
      case AlertType.success:
        return Colors.green[800];
      case AlertType.warning:
        return Colors.orange[800];
    }

    return Colors.white;
  }
}
