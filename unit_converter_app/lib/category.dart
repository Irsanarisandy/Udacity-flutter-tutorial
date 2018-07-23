import 'package:flutter/material.dart';
// @required is defined in the meta.dart package
import 'package:meta/meta.dart';
import 'package:unit_converter_app/converter_screen.dart';
import 'package:unit_converter_app/unit.dart';

// NOTE: Variables or functions with underscores at front are private
final _widgetHeight = 100.0;
final _widgetBorderRadius = BorderRadius.circular(_widgetHeight/2);

class Category extends StatelessWidget {
  // While the @required checks for whether a named parameter is passed in,
  // it doesn't check whether the object passed in is null. We check that
  // in the assert statement.
  const Category({
    Key key,
    @required this.name,
    @required this.color,
    @required this.iconLocation,
    @required this.units,
  }) : assert(name != null),
       assert(color != null),
       assert(iconLocation != null),
       assert(units != null),
       super(key: key);

  final String name;
  final ColorSwatch color;
  final IconData iconLocation;
  final List<Unit> units;

  void _navigateToConverter(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              name,
              style: Theme.of(context).textTheme.display1,
            ),
            centerTitle: true,
            elevation: 1.0,
            backgroundColor: color,
          ),
          body: ConverterScreen(
            name: name,
            color: color,
            units: units
          ),
          // This prevents the attempt to resize the screen when the keyboard
          // is opened
          resizeToAvoidBottomPadding: false,
        );
      })
    );
  }

  @override
  // This `context` parameter describes the location of this widget in the
  // widget tree. It can be used for obtaining Theme data from the nearest
  // Theme ancestor in the tree. Below, we obtain the display1 text theme.
  // See https://docs.flutter.io/flutter/material/Theme-class.html
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: _widgetHeight,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: InkWell(
            borderRadius: _widgetBorderRadius,
            onTap: () => _navigateToConverter(context),
            highlightColor: color['highlight'],
            splashColor: color['splash'],
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(
                    iconLocation,
                    size: 60.0,
                  ),
                ),
                Center(
                  child: Text(
                    name,
                    // Use built-in theme from ".of(context)"
                    // See https://docs.flutter.io/flutter/material/TextTheme-class.html
                    style: Theme.of(context).textTheme.headline,
                  ),
                )
              ],
            ),
          ),
        )
      )
    );
  }
}