import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raf_airlines_admin/dashboard/flights/bloc/flights_bloc.dart';
import 'package:raf_airlines_admin/dashboard/flights/new_flight/bloc/new_flight_bloc.dart';
import 'package:raf_airlines_admin/models/airplane.dart';
import 'package:raf_airlines_admin/services/airplane/airplane_service.dart';
import 'package:raf_airlines_admin/services/flight/flight_service.dart';
import 'package:raf_airlines_admin/services/service_provider.dart';
import 'package:raf_airlines_admin/ui/alert.dart';
import 'package:raf_airlines_admin/ui/fade_in_widget.dart';
import 'package:raf_airlines_admin/ui/white_panel.dart';

class NewFlightTab extends StatefulWidget {
  @override
  _NewFlightTabState createState() => _NewFlightTabState();
}

class _NewFlightTabState extends State<NewFlightTab> {
  final TextEditingController _startDestController = TextEditingController();
  final TextEditingController _endDestController = TextEditingController();
  final TextEditingController _distanceController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Airplane? _selectedAirplane;

  void _onAirplaneSelected(Airplane? airplane) {
    setState(() {
      _selectedAirplane = airplane;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewFlightBloc>(
      create: (context) => NewFlightBloc(
          airplaneService: getService<AirplaneService>(),
          flightService: getService<FlightService>(),
          flightsBloc: BlocProvider.of<FlightsBloc>(context))
        ..add(NewFlightInit()),
      child: BlocConsumer<NewFlightBloc, NewFlightState>(listener: (context, state) {
        if (state is NewFlightInitial || state is NewFlightCreated) {
          _startDestController.clear();
          _endDestController.clear();
          _distanceController.clear();
          _priceController.clear();

          setState(() {
            _selectedAirplane = null;
          });
        }
      }, builder: (context, state) {
        if (state is NewFlightLoading)
          return Center(
            child: CircularProgressIndicator(),
          );
        return WhitePanel(
            title: "Create new flight",
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.airplanemode_active),
                    title: DropdownButton<Airplane>(
                      isExpanded: true,
                      value: _selectedAirplane,
                      items: state.airplanes!
                          .map((plane) =>
                              DropdownMenuItem<Airplane>(value: plane, child: Text(plane.name!)))
                          .toList(),
                      onChanged: (plane) => _onAirplaneSelected(plane),
                    ),
                    subtitle: Text("Airplane"),
                  ),
                  ListTile(
                    leading: Icon(Icons.flight_takeoff),
                    title: TextFormField(
                      controller: _startDestController,
                      maxLength: 3,
                      validator: (text) {
                        return text!.trim().length == 3
                            ? null
                            : "Airport must contain exactly 3 letters";
                      },
                    ),
                    subtitle: Text("Start destination airport"),
                  ),
                  ListTile(
                    leading: Icon(Icons.flight_land),
                    title: TextFormField(
                      controller: _endDestController,
                      maxLength: 3,
                      validator: (text) {
                        return text!.trim().length == 3
                            ? null
                            : "Airport must contain exactly 3 letters";
                      },
                    ),
                    subtitle: Text("End destination airport"),
                  ),
                  ListTile(
                    leading: Icon(Icons.assistant_navigation),
                    title: TextFormField(
                      controller: _distanceController,
                      validator: (text) {
                        return int.tryParse(text!) != null && int.parse(text) > 0
                            ? null
                            : "Distance must be a positive whole number";
                      },
                    ),
                    subtitle: Text("Flight distance in kilometers"),
                  ),
                  ListTile(
                    leading: Icon(Icons.monetization_on_rounded),
                    title: TextFormField(
                      controller: _priceController,
                      validator: (text) {
                        return double.tryParse(text!) != null && double.parse(text) > 0
                            ? null
                            : "Price must be a positive number";
                      },
                    ),
                    subtitle: Text("Flight price in EUR"),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  MaterialButton(
                    padding: const EdgeInsets.all(18),
                    child: Text(
                      "Create flight",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      if (_formKey.currentState!.validate())
                        BlocProvider.of<NewFlightBloc>(context).add(NewFlightProvided(
                            airplane: _selectedAirplane,
                            startDestination: _startDestController.text,
                            endDestination: _endDestController.text,
                            distance: _distanceController.text,
                            price: _priceController.text));
                    },
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  if (state is NewFlightCreated)
                    FadeInWidget(
                        child: Alert(
                            type: AlertType.success, text: "New flight successfully created!"))
                  else if (state is NewFlightError)
                    FadeInWidget(
                        child: Alert(
                            type: AlertType.error,
                            text: "There was an error creating new flight!")),
                ],
              ),
            ));
      }),
    );
  }
}
