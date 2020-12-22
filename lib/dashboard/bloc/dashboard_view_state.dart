part of 'dashboard_view_bloc.dart';

abstract class DashboardViewState extends Equatable {
  String get title;

  @override
  List<Object> get props => [title];
}

abstract class TabbedViewState extends DashboardViewState {
  List<TabView> get views;
}

abstract class SingleViewState extends DashboardViewState {
  String get subtitle;

  Widget get view;
}

class HomeViewState extends SingleViewState {
  @override
  String get title => "Home";

  @override
  String get subtitle => "Home view Lorem Ipsum text for a subtitle space";

  @override
  Widget get view => Center(child: Text("Home view"));
}

class AirplanesPageViewState extends TabbedViewState {

  final List<TabView> views;

  @override
  String get title => "Airplanes";

  AirplanesPageViewState({@required this.views});
}

class FlightsPageViewState extends TabbedViewState {

  final List<TabView> views;

  @override
  String get title => "Flights";

  FlightsPageViewState({@required this.views});
}

class ErrorViewState extends SingleViewState {
  @override
  String get title => "Error";

  @override
  String get subtitle => "Error view Lorem Ipsum text for a subtitle space";

  @override
  Widget get view => Center(
    child: Text("Error view"),
  );
}
