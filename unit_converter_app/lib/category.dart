import 'package:flutter/material.dart';

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
    @required this.iconLocation
  }) : assert(name != null),
       assert(color != null),
       assert(iconLocation != null),
       super(key: key);

  final String name;
  final ColorSwatch color;
  final IconData iconLocation;

  void _isTapped() {
    print('I was tapped!');
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
            onTap: _isTapped,
            splashColor: color,
            highlightColor: color,
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
                    // https://docs.flutter.io/flutter/material/TextTheme-class.html
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