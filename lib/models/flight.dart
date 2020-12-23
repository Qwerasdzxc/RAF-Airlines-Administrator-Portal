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

  Flight copyWith(
          {int id,
          int distance,
          Airplane airplane,
          String startDestination,
          String endDestination,
          double price,
          bool canceled}) =>
      Flight(
          id: id ?? this.id,
          distance: distance ?? this.distance,
          airplane: airplane ?? this.airplane,
          startDestination: startDestination ?? this.startDestination,
          endDestination: endDestination ?? this.endDestination,
          price: price ?? this.price,
          canceled: canceled ?? this.canceled);

  @override
  List<Object> get props => [id];
}
