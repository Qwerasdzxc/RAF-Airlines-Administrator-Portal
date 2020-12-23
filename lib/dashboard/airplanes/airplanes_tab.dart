import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raf_airlines_admin/dashboard/airplanes/bloc/airplanes_bloc.dart';
import 'package:raf_airlines_admin/models/airplane.dart';

class AirplanesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AirplanesBloc, AirplanesState>(builder: (context, state) {
      if (state is AirplanesLoaded && state.airplanes.isNotEmpty)
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "All airplanes",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Divider(),
                  Expanded(
                      child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: DataTable(
                      showBottomBorder: true,
                      columns: [
                        DataColumn(
                            label: Text(
                          "Id",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                        DataColumn(
                            label: Text(
                          "Name",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                        DataColumn(
                            label: Text(
                              "Capacity",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            numeric: true),
                        DataColumn(
                            label: Text(
                              "Delete",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            numeric: true)
                      ],
                      rows: state.airplanes
                          .map((plane) => DataRow(cells: [
                                DataCell(Text(plane.id.toString())),
                                DataCell(Text(plane.name)),
                                DataCell(Text(plane.capacity.toString())),
                                DataCell(IconButton(
                                  icon: Icon(
                                    Icons.delete_forever,
                                    color: Colors.red,
                                  ),
                                  onPressed: () => _showConfirmationDialog(context, plane),
                                )),
                              ]))
                          .toList(),
                    ),
                  ))
                ],
              ),
            ),
          ),
        );
      else if (state is AirplanesLoaded && state.airplanes.isEmpty)
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.airplanemode_inactive,
                size: 64,
                color: Colors.grey,
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                "There are currently no airplanes available to display",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      else if (state is AirplanesLoading)
        return Center(child: CircularProgressIndicator());
      else
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error,
                size: 64,
                color: Colors.grey,
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                "An error occurred!\nPlease try again later",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 32,
              ),
              MaterialButton(
                padding: const EdgeInsets.all(18),
                child: Text(
                  "Refresh",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                color: Theme.of(context).primaryColor,
                onPressed: () =>
                    BlocProvider.of<AirplanesBloc>(context).add(GetAllAirplanesEvent()),
              )
            ],
          ),
        );
    });
  }

  void _showConfirmationDialog(BuildContext context, Airplane airplane) {
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () => Navigator.pop(context),
    );

    Widget continueButton = FlatButton(
      child: Text("Delete"),
      onPressed: () {
        BlocProvider.of<AirplanesBloc>(context).add(DeleteAirplaneEvent(airplane: airplane));
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Row(
        children: [
          Icon(
            Icons.warning,
            color: Colors.red,
          ),
          SizedBox(
            width: 12,
          ),
          Text(
            "Confirmation",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      content: Text("Are you sure you wish to delete airplane: " +
          airplane.name +
          "?\n\nThis action cannot be revoked!"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(context: context, builder: (_) => alert);
  }
}
