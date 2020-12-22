import 'package:flutter/material.dart';
import 'package:raf_airlines_admin/dashboard/bloc/dashboard_view_bloc.dart';

enum NavigationCategory {
  home, projects, other
}

abstract class SidebarItem {

  final String title;

  SidebarItem(this.title);
}

class NavigationModel extends SidebarItem {
  DashboardViewEvent option;
  IconData icon;

  NavigationModel({@required this.option, @required String title, @required this.icon}) : super(title);
}

class CategoryModel extends SidebarItem {
  CategoryModel({@required String title}) : super(title);
}