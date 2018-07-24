import 'package:flutter/material.dart';
// @required is defined in the meta.dart package
import 'package:meta/meta.dart';
import 'category.dart';

// NOTE: Variables or functions with underscores at front are private
final _widgetHeight = 100.0;
final _widgetBorderRadius = BorderRadius.circular(_widgetHeight/2);

class CategoryTile extends StatelessWidget {
  const CategoryTile({
    Key key,
    @required this.category,
    @required this.onTap,
  })  : assert(category != null),
        assert(onTap != null),
        super(key: key);

  final Category category;
  final ValueChanged<Category> onTap;

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
            onTap: () => onTap(category),
            highlightColor: category.color['highlight'],
            splashColor: category.color['splash'],
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(
                    category.iconLocation,
                    size: 60.0,
                  ),
                ),
                Center(
                  child: Text(
                    category.name,
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