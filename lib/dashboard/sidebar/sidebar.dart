import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:raf_airlines_admin/dashboard/bloc/dashboard_view_bloc.dart';
import 'package:raf_airlines_admin/dashboard/sidebar/sidebar_list_item.dart';
import 'package:raf_airlines_admin/dashboard/sidebar/sidebar_theme.dart';
import 'package:raf_airlines_admin/ui/horizontal_text_divider.dart';

import 'model/navigation_model.dart';

class Sidebar extends StatefulWidget {
  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> with SingleTickerProviderStateMixin {
  double maxWidth = 210;
  double minWidth = 70;

  bool isCollapsed = false;

  AnimationController _animationController;
  Animation<double> widthAnimation;

  String _selectedItem = "";

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 60));
    widthAnimation = Tween<double>(begin: maxWidth, end: minWidth).animate(_animationController);
  }

  Widget _sidebarItem(SidebarItem navItem) {
    if (navItem is NavigationModel)
      return SidebarListItem(
        onTap: () {
          if (navItem.title == _selectedItem)
            return;

          setState(() {
            BlocProvider.of<DashboardViewBloc>(context).add(navItem.option);
            _selectedItem = navItem.title;
          });
        },
        isSelected: _selectedItem == navItem.title,
        title: navItem.title,
        icon: navItem.icon,
        animationController: _animationController,
      );
    else if (navItem is CategoryModel) {
      if (widthAnimation.value == maxWidth)
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: HorizontalTextDivider(
            text: navItem.title,
            color: Colors.white30,
            textColor: Colors.blue[200],
          ),
        );
      else
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Container(
            margin: EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
            height: 2,
            color: Colors.white30,
          ),
        );
    }

    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        builder: (context, widget) => Material(
              elevation: 5,
              child: Container(
                width: widthAnimation.value,
                color: drawerBackgroundColor,
                child: Column(
                  children: <Widget>[
                    SidebarListItem(
                      title: 'RAF Airlines',
                      logo: true,
                      widget: FlutterLogo(
                        textColor: Theme.of(context).primaryColor,
                      ),
                      animationController: _animationController,
                    ),
                    Divider(
                      height: 8,
                    ),
                    SidebarListItem(
                        title: 'Administrator',
                        subtitle: 'RAF Airlines',
                        icon: Icons.person,
                        animationController: _animationController,
                        lighten: true),
                    SizedBox(
                      height: 12,
                    ),
                    _sidebarItem(
                      CategoryModel(title: "Administration"),
                    ),
                    _sidebarItem(
                      NavigationModel(
                          option: AirplanesView(),
                          title: "Airplanes",
                          icon: Icons.airplanemode_active),
                    ),
                    _sidebarItem(
                      NavigationModel(
                          option: FlightsView(),
                          title: "Flights",
                          icon: Icons.flight_takeoff),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Divider(color: Colors.white30,),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isCollapsed = !isCollapsed;
                          isCollapsed
                              ? _animationController.forward()
                              : _animationController.reverse();
                        });
                      },
                      child: AnimatedIcon(
                        icon: AnimatedIcons.close_menu,
                        progress: _animationController,
                        color: selectedColor,
                        size: 30,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ));
  }
}
