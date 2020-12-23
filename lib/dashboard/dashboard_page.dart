import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raf_airlines_admin/dashboard/sidebar/sidebar.dart';

import 'bloc/dashboard_view_bloc.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> with TickerProviderStateMixin {

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
              child: BlocBuilder<DashboardViewBloc, DashboardViewState>(
                  builder: (context, state) => state.view),
            ))
          ],
        ),
      ),
    ));
  }
}
