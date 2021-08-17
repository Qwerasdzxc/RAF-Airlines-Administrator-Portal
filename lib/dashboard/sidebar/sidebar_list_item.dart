import 'package:auto_size_text/auto_size_text.dart';

import 'package:flutter/material.dart';
import 'package:raf_airlines_admin/dashboard/sidebar/sidebar_theme.dart';

class SidebarListItem extends StatefulWidget {
  final String title;
  final String? subtitle;

  final bool isSelected;
  final bool lighten;
  final bool logo;
  final bool secondary;

  final IconData? icon;
  final Widget? widget;
  final AnimationController? animationController;
  final Function? onTap;

  SidebarListItem(
      {required this.title,
      required this.animationController,
      this.icon,
      this.subtitle,
      this.widget,
      this.isSelected = false,
      this.secondary = false,
      this.lighten = false,
      this.logo = false,
      this.onTap});

  @override
  _SidebarListItemState createState() => _SidebarListItemState();
}

class _SidebarListItemState extends State<SidebarListItem> {
  late Animation<double> widthAnimation, sizedBoxAnimation;

  @override
  void initState() {
    super.initState();
    widthAnimation = Tween<double>(begin: 200, end: 70).animate(widget.animationController!);
    sizedBoxAnimation = Tween<double>(begin: 10, end: 0).animate(widget.animationController!);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap as void Function()?,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
          color: widget.isSelected
              ? Colors.transparent.withOpacity(0.3)
              : widget.lighten ? Color(0x545B62).withOpacity(0.3) : Colors.transparent,
        ),
        width: widthAnimation.value,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment:
              widthAnimation.value < 190 ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: <Widget>[
            widget.icon != null
                ? Icon(
                    widget.icon,
                    color: widget.isSelected || widget.secondary ? selectedColor : Colors.white30,
                    size: 20.0,
                  )
                : Container(
                    width: 20,
                    height: 20,
                    child: widget.widget,
                  ),
            SizedBox(width: sizedBoxAnimation.value),
            (widthAnimation.value >= 190)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      AutoSizeText(widget.title,
                          style: widget.isSelected
                              ? listTitleSelectedTextStyle
                              : widget.secondary
                                  ? listTitleSecondaryTextStyle
                                  : listTitleDefaultTextStyle),
                      widget.subtitle != null
                          ? AutoSizeText(widget.subtitle!,
                              textAlign: TextAlign.start,
                              style: widget.isSelected
                                  ? listSubtitleSelectedTextStyle
                                  : listSubtitleDefaultTextStyle)
                          : Container(),
                    ],
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
