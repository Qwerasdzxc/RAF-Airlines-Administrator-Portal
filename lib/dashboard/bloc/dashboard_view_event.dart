part of 'dashboard_view_bloc.dart';

abstract class DashboardViewEvent extends Equatable {
  const DashboardViewEvent();

  @override
  List<Object> get props => [];
}

class HomeView extends DashboardViewEvent {}

class AirplanesView extends DashboardViewEvent {}

class FlightsView extends DashboardViewEvent {}

class ErrorView extends DashboardViewEvent {}
