import 'package:flutter/material.dart';
// @required is defined in the meta.dart package
import 'package:meta/meta.dart';
import 'package:unit_converter_app/unit.dart';

class _ConverterScreenState extends State<ConverterScreen> {
  @override
  Widget build(BuildContext context) {
    // Here is just a placeholder for a list of mock units
    final unitWidgets = widget.units.map((Unit unit) {
      return Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(16.0),
        color: widget.color,
        child: Column(
          children: <Widget>[
            Text(
              unit.name,
              style: Theme.of(context).textTheme.headline,
            ),
            Text(
              'Conversion: ${unit.conversion}',
              style: Theme.of(context).textTheme.subhead,
            ),
          ],
        ),
      );
    }).toList();

    return ListView(
      children: unitWidgets,
    );
  }
}

class ConverterScreen extends StatefulWidget {
  const ConverterScreen({
    Key key,
    @required this.name,
    @required this.color,
    @required this.units,
  }) : assert(name != null),
        assert(color != null),
        assert(units != null),
        super(key: key);

  final String name;
  final ColorSwatch color;
  final List<Unit> units;

  @override
  _ConverterScreenState createState() => _ConverterScreenState();
}