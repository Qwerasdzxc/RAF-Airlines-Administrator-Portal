import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raf_airlines_admin/dashboard/sidebar/sidebar.dart';

import 'bloc/dashboard_view_bloc.dart';
import 'navbar/navbar.dart';

class DashboardPage extends StatefulWidget {

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> with TickerProviderStateMixin {

  Widget _tabbedView(TabbedViewState state) {
    final controller = TabController(length: state.views.length, vsync: this);

    return Column(
      children: <Widget>[
        Container(
          height: kToolbarHeight * 1.75,
          child: Material(elevation: 0, child: Navbar(controller: controller)),
        ),
        Expanded(
          child: AnimatedSwitcher(
            layoutBuilder: (currChild, prevChildren) => currChild,
            duration: Duration(milliseconds: 500),
            child: TabBarView(
                key: ValueKey<int>(state.hashCode),
                controller: controller,
                physics: NeverScrollableScrollPhysics(),
                children: state.views.map((page) => page.view).toList()),
          ),
        ),
      ],
    );
  }

  Widget _singleView(SingleViewState state) {
    return Column(
      children: <Widget>[
        Container(
          height: kToolbarHeight * 1.75,
          child: Material(elevation: 0, child: Navbar()),
        ),
        Expanded(
          child: AnimatedSwitcher(
            layoutBuilder: (currChild, prevChildren) => currChild,
            duration: Duration(milliseconds: 500),
            child: Container(key: ValueKey<int>(state.hashCode), child: state.view),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: BlocProvider<DashboardViewBloc>(
            create: (context) => DashboardViewBloc(),
            child: Row(
              children: <Widget>[
                Sidebar(),
                Expanded(
                    child: Container(
                      color: Color.fromRGBO(235, 232, 226, 1),
                      child: BlocBuilder<DashboardViewBloc, DashboardViewState>(builder: (context, state) {
                        return Container(
                          child: state is TabbedViewState ? _tabbedView(state) : _singleView(state),
                        );
                      }),
                    ))
              ],
            ),
          ),
        ));
  }
}
