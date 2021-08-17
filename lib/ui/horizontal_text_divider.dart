import 'package:flutter/material.dart';

class HorizontalTextDivider extends StatelessWidget {
  final String? text;

  final Color color;
  final Color? textColor;

  const HorizontalTextDivider(
      {Key? key, this.text, this.color = Colors.black12, this.textColor = Colors.black26})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
        child: Container(
            margin: const EdgeInsets.only(left: 10.0, right: 15.0),
            child: SizedBox(
              height: 10,
              child: Center(
                child: Container(
                  margin: EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
                  height: 2,
                  color: color,
                ),
              ),
            )),
      ),
      Text(
        text ?? "",
        style: TextStyle(color: textColor),
      ),
      Expanded(
        child: Container(
            margin: const EdgeInsets.only(left: 15.0, right: 10.0),
            child: SizedBox(
              height: 10,
              child: Center(
                child: Container(
                  margin: EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
                  height: 2,
                  color: color,
                ),
              ),
            )),
      ),
    ]);
  }
}