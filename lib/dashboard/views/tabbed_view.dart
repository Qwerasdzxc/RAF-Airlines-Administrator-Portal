import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raf_airlines_admin/dashboard/bloc/dashboard_view_bloc.dart';
import 'package:raf_airlines_admin/dashboard/navbar/navbar.dart';

class TabbedView<T extends Bloc> extends StatefulWidget {

  final TabbedViewState state;

  const TabbedView({Key? key, required this.state}) : super(key: key);

  @override
  _TabbedViewState<T> createState() => _TabbedViewState<T>();
}

class _TabbedViewState<T extends Bloc> extends State<TabbedView<T>> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final controller = TabController(length: widget.state.views.length, vsync: this);

    return Column(
      children: <Widget>[
        Container(
          height: kToolbarHeight * 1.75,
          child: Material(elevation: 0, child: Navbar(controller: controller)),
        ),
        Expanded(
          child: AnimatedSwitcher(
            layoutBuilder: (currChild, prevChildren) => currChild!,
            duration: Duration(milliseconds: 500),
            child: BlocProvider<T>(
              create: widget.state.bloc as T Function(BuildContext),
              child: TabBarView(
                  key: ValueKey<int>(widget.state.hashCode),
                  controller: controller,
                  physics: NeverScrollableScrollPhysics(),
                  children: widget.state.views.map((page) => page.view).toList()),
            ),
          ),
        ),
      ],
    );
  }
}
