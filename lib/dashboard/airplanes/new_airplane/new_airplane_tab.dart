import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raf_airlines_admin/dashboard/airplanes/bloc/airplanes_bloc.dart';
import 'package:raf_airlines_admin/dashboard/airplanes/new_airplane/bloc/new_airplane_bloc.dart';
import 'package:raf_airlines_admin/services/airplane/airplane_service.dart';
import 'package:raf_airlines_admin/services/service_provider.dart';
import 'package:raf_airlines_admin/ui/alert.dart';
import 'package:raf_airlines_admin/ui/fade_in_widget.dart';
import 'package:raf_airlines_admin/ui/white_panel.dart';

class NewAirplaneTab extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _capacityController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewAirplaneBloc>(
      create: (context) => NewAirplaneBloc(
          service: getService<AirplaneService>(),
          airplanesBloc: BlocProvider.of<AirplanesBloc>(context)),
      child: BlocConsumer<NewAirplaneBloc, NewAirplaneState>(
        listener: (context, state) {
          if (state is NewAirplaneInitial || state is NewAirplaneCreated) {
            _nameController.clear();
            _capacityController.clear();
          }
        },
        builder: (context, state) => WhitePanel(
            title: "Create new airplane",
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.format_color_text),
                    title: TextFormField(
                      controller: _nameController,
                      validator: (text) {
                        return text!.trim().length > 5
                            ? null
                            : "Name must contain minimum 6 characters";
                      },
                    ),
                    subtitle: Text("Airplane name"),
                  ),
                  ListTile(
                    leading: Icon(Icons.reduce_capacity),
                    title: TextFormField(
                      controller: _capacityController,
                      validator: (text) {
                        return int.tryParse(text!) != null
                            ? null
                            : "Capacity must be a whole number";
                      },
                    ),
                    subtitle: Text("Airplane capacity"),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  if (state is NewAirplaneLoading)
                    Center(child: CircularProgressIndicator(),)
                  else
                    MaterialButton(
                      padding: const EdgeInsets.all(18),
                      child: Text(
                        "Create airplane",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        if (_formKey.currentState!.validate())
                          BlocProvider.of<NewAirplaneBloc>(context).add(NewAirplaneProvided(
                              name: _nameController.text, capacity: _capacityController.text));
                      },
                    ),
                  SizedBox(
                    height: 24,
                  ),
                  if (state is NewAirplaneCreated)
                    FadeInWidget(
                        child: Alert(
                            type: AlertType.success, text: "New airplane successfully created!"))
                  else if (state is NewAirplaneError)
                    FadeInWidget(
                        child: Alert(
                            type: AlertType.error,
                            text: "There was an error creating new airplane!")),
                  SizedBox(height: 64,),
                ],
              ),
            )),
      ),
    );
  }
}
