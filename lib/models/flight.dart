import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:raf_airlines_admin/models/airplane.dart';

class Flight extends Equatable {
  final int id;
  final int distance;

  final Airplane airplane;

  final String startDestination;
  final String endDestination;

  final double price;

  final bool canceled;

  Flight(
      {@required this.id,
      @required this.distance,
      @required this.airplane,
      @required this.startDestination,
      @required this.endDestination,
      @required this.price,
      @required this.canceled});

  factory Flight.fromJson(Map json) => Flight(
      id: json["flightId"],
      distance: json["distance"],
      airplane: Airplane.fromJson(json["airplane"]),
      startDestination: json["startDestination"],
      endDestination: json["endDestination"],
      price: json["price"],
      canceled: json["canceled"]);

  @override
  List<Object> get props => [id];
}
