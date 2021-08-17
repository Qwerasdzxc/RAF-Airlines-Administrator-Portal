import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raf_airlines_admin/dashboard/flights/bloc/flights_bloc.dart';
import 'package:raf_airlines_admin/ui/dialogs.dart';
import 'package:raf_airlines_admin/ui/white_panel.dart';

class FlightsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FlightsBloc, FlightsState>(builder: (context, state) {
      if (state is FlightsLoaded && state.flights!.isNotEmpty)
        return WhitePanel(
            title: "All flights",
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
                      "Airplane",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                      label: Text(
                    "Start destination",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                  DataColumn(
                    label: Text(
                      "End destination",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Distance (KM)",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                      numeric: true
                  ),
                  DataColumn(
                    label: Text(
                      "Price (EUR)",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                      numeric: true
                  ),
                  DataColumn(
                    label: Text(
                      "Canceled",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                      numeric: true
                  ),
                  DataColumn(
                      label: Text(
                        "Abort",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      numeric: true)
                ],
                rows: state.flights!
                    .map((flight) => DataRow(cells: [
                          DataCell(Text(flight.id.toString())),
                          DataCell(Text(flight.airplane!.name!)),
                          DataCell(Text(flight.startDestination!)),
                          DataCell(Text(flight.endDestination!)),
                          DataCell(Text(flight.distance.toString())),
                          DataCell(Text(flight.price.toString())),
                          DataCell(Checkbox(
                            value: flight.canceled,
                            onChanged: null,
                          )),
                          DataCell(IconButton(
                            icon: Icon(
                              Icons.airplanemode_inactive,
                              color: Colors.red,
                            ),
                            onPressed: () => Dialogs.showConfirmationDialog(
                                context: context,
                                content: "Are you sure you wish to abort flight with Id: " +
                                    flight.id.toString() +
                                    "?\n\nThis action cannot be revoked!",
                                callback: () => BlocProvider.of<FlightsBloc>(context)
                                    .add(DeleteFlightEvent(flight: flight))),
                          )),
                        ]))
                    .toList(),
              ),
            ));
      else if (state is FlightsLoaded && state.flights!.isEmpty)
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
                "There are currently no flights available to display",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      else if (state is FlightsLoading)
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
                onPressed: () => BlocProvider.of<FlightsBloc>(context).add(GetAllFlightsEvent()),
              )
            ],
          ),
        );
    });
  }
}
