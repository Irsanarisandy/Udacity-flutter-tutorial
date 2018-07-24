import 'package:flutter/material.dart';
// @required is defined in the meta.dart package
import 'package:meta/meta.dart';
import 'unit.dart';

class Category {
  // While the @required checks for whether a named parameter is passed in,
  // it doesn't check whether the object passed in is null. We check that
  // in the assert statement.
  const Category({
    @required this.name,
    @required this.color,
    @required this.iconLocation,
    @required this.units,
  }) : assert(name != null),
       assert(color != null),
       assert(iconLocation != null),
       assert(units != null);

  final String name;
  final ColorSwatch color;
  final String iconLocation;
  final List<Unit> units;
}