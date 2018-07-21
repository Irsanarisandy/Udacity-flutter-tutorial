import 'package:flutter/material.dart';
import 'package:unit_converter_app/category.dart';

final _backgroundColor = Colors.green[100];

class CategoryScreen extends StatelessWidget {
  const CategoryScreen();

  static const _categoryNames = <String>[
    'Length',
    'Area',
    'Volume',
    'Mass',
    'Time',
    'Digital Storage',
    'Energy',
    'Currency',
  ];

  static const _baseColors = <Color>[
    Colors.teal,
    Colors.orange,
    Colors.pinkAccent,
    Colors.blueAccent,
    Colors.yellow,
    Colors.greenAccent,
    Colors.purpleAccent,
    Colors.red,
  ];

  Widget _buildCategoryWidgets(List<Category> categories) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) => categories[index],
      itemCount: categories.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    final categories = <Category>[];
    for (var i = 0; i < _categoryNames.length; i++) {
      categories.add(
          Category(
            name: _categoryNames[i],
            color: _baseColors[i],
            iconLocation: Icons.cake
          )
      );
    }

    final appBar = AppBar(
      title: Text(
        'Unit Converter',
        style: TextStyle(
          fontSize: 30.0,
          color: Colors.black,
        ),
      ),
      centerTitle: true,
      elevation: 0.0,
      backgroundColor: _backgroundColor,
    );

    final categoryView = Container(
      child: _buildCategoryWidgets(categories),
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      color: _backgroundColor,
    );

    return Scaffold(
      appBar: appBar,
      body: categoryView,
    );
  }
}