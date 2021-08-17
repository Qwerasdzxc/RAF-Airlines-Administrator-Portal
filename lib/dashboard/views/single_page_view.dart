import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raf_airlines_admin/dashboard/bloc/dashboard_view_bloc.dart';
import 'package:raf_airlines_admin/dashboard/navbar/navbar.dart';

class SinglePageView<T extends Bloc> extends StatelessWidget {
  final SingleViewState? state;

  const SinglePageView({Key? key, this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: kToolbarHeight * 1.75,
          child: Material(elevation: 0, child: Navbar()),
        ),
        Expanded(
          child: AnimatedSwitcher(
            layoutBuilder: (currChild, prevChildren) => currChild!,
            duration: Duration(milliseconds: 500),
            child: BlocProvider<T>(
                create: state!.bloc as T Function(BuildContext),
                child: Container(key: ValueKey<int>(state.hashCode), child: state!.view)),
          ),
        ),
      ],
    );
  }
}
