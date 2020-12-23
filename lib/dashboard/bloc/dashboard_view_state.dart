part of 'dashboard_view_bloc.dart';

abstract class DashboardViewState<T> extends Equatable {
  String get title;

  IconData get icon;

  Cubit<Object> Function(BuildContext context) get bloc;

  Widget get view;

  @override
  List<Object> get props => [title];
}

abstract class TabbedViewState extends DashboardViewState {
  List<TabView> get views;
}

abstract class SingleViewState extends DashboardViewState {
  String get subtitle;
}

class HomeViewState extends SingleViewState {
  @override
  String get title => "Home";

  @override
  IconData get icon => Icons.home;

  @override
  String get subtitle => "Home view Lorem Ipsum text for a subtitle space";

  @override
  Cubit<Object> Function(BuildContext context) get bloc => null;

  @override
  Widget get view => Center(child: Text("Home view"));
}

class AirplanesPageViewState extends TabbedViewState {
  final List<TabView> views;

  @override
  String get title => "Airplanes";

  @override
  IconData get icon => Icons.airplanemode_active;

  @override
  Widget get view => TabbedView<AirplanesBloc>(state: this);

  @override
  AirplanesBloc Function(BuildContext context) get bloc => (context) =>
      AirplanesBloc(service: getService<AirplaneService>())..add(GetAllAirplanesEvent());

  AirplanesPageViewState({@required this.views});
}

class FlightsPageViewState extends TabbedViewState {
  final List<TabView> views;

  @override
  String get title => "Flights";

  @override
  IconData get icon => Icons.flight_takeoff;

  @override
  Widget get view => TabbedView<FlightsBloc>(state: this);

  @override
  FlightsBloc Function(BuildContext context) get bloc =>
      (context) => FlightsBloc(service: getService<FlightService>())..add(GetAllFlightsEvent());

  FlightsPageViewState({@required this.views});
}

class ErrorViewState extends SingleViewState {
  @override
  String get title => "Error";

  @override
  String get subtitle => "Error view Lorem Ipsum text for a subtitle space";

  @override
  IconData get icon => Icons.error;

  @override
  Cubit<Object> Function(BuildContext context) get bloc => null;

  @override
  Widget get view => Center(
        child: Text("Error view"),
      );
}
