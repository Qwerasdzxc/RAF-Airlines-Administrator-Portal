import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Airplane extends Equatable {
  final int id;
  final int capacity;

  final String name;

  Airplane({@required this.id, @required this.capacity, @required this.name});

  factory Airplane.fromJson(Map json) =>
      Airplane(id: json["airplaneId"], capacity: json["capacity"], name: json["name"]);

  @override
  List<Object> get props => [id];
}
