import 'package:flutter/material.dart';
import 'package:unit_converter_app/category.dart';
import 'package:unit_converter_app/unit.dart';

final _backgroundColor = Colors.green[100];

class _CategoryScreenState extends State<CategoryScreen> {
  final _categories = <Category>[];

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

  // Returns a list of mock [Unit]s.
  List<Unit> _retrieveUnitList(String categoryName) {
    return List.generate(10, (int i) {
      i += 1;
      return Unit(
        name: '$categoryName Unit $i',
        conversion: i.toDouble(),
      );
    });
  }

  @override
  void initState() {
    super.initState();

    for (var i = 0; i < _categoryNames.length; i++) {
      _categories.add(
          Category(
            name: _categoryNames[i],
            color: _baseColors[i],
            iconLocation: Icons.cake,
            units: _retrieveUnitList(_categoryNames[i]),
          )
      );
    }
  }

  Widget _buildCategoryWidgets() {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) => _categories[index],
      itemCount: _categories.length,
    );
  }

  @override
  Widget build(BuildContext context) {
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
      child: _buildCategoryWidgets(),
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      color: _backgroundColor,
    );

    return Scaffold(
      appBar: appBar,
      body: categoryView,
    );
  }
}

class CategoryScreen extends StatefulWidget {
  const CategoryScreen();

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}