import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Airplane extends Equatable {
  final int? id;
  final int? capacity;

  final String? name;

  Airplane({this.id, required this.capacity, required this.name});

  factory Airplane.fromJson(Map json) =>
      Airplane(id: json["airplaneId"], capacity: json["capacity"], name: json["name"]);

  Airplane copyWith({int? id, int? capacity, String? name}) =>
      Airplane(id: id ?? this.id, capacity: capacity ?? this.capacity, name: name ?? this.name);

  @override
  List<Object?> get props => [id];
}
