import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raf_airlines_admin/dashboard/bloc/dashboard_view_bloc.dart';

class Navbar extends StatefulWidget {

  final TabController controller;

  const Navbar({Key key, this.controller}) : super(key: key);

  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardViewBloc, DashboardViewState>(
      builder: (context, state) => Row(
        children: <Widget>[
          Flexible(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                    child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12, top: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              FlutterLogo(textColor: Theme.of(context).primaryColor,),
                              SizedBox(
                                width: 12,
                              ),
                              Flexible(
                                child: AutoSizeText(
                                  state.title,
                                  style: GoogleFonts.ubuntu(fontSize: 20, fontWeight: FontWeight.w900),
                                ),
                              ),
                            ],
                          ),
                        ))),
                if (state is TabbedViewState)
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: TabBar(
                      controller: widget.controller,
                      isScrollable: true,
                      indicatorColor: Colors.blue,
                      labelColor: Colors.black,
                      labelStyle: GoogleFonts.ubuntu(fontWeight: FontWeight.w400, fontSize: 15),
                      tabs: state.views.map<Tab>((page) => page.tab).toList(),
                    ),
                  )
                else if (state is SingleViewState)
                  Container(
                    height: 48,
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, bottom: 10),
                          child: Text(
                            state.subtitle,
                            style: TextStyle(color: Colors.black26),
                          ),
                        )),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
