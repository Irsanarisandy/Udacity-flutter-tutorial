import 'package:flutter/material.dart';
import 'category.dart';
import 'category_tile.dart';
import 'unit_converter.dart';
import 'unit.dart';
import 'backdrop.dart';

class _CategoryScreenState extends State<CategoryScreen> {
  // When extending state, the variables are either set in initState or setState
  final _categories = <Category>[];
  Category _defaultCategory;
  Category _currentCategory;

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

  static const _baseColors = <ColorSwatch>[
    ColorSwatch(0xFF6AB7A8, {
      'highlight': Color(0xFF6AB7A8),
      'splash': Color(0xFF0ABC9B),
    }),
    ColorSwatch(0xFFFFD28E, {
      'highlight': Color(0xFFFFD28E),
      'splash': Color(0xFFFFA41C),
    }),
    ColorSwatch(0xFFFFB7DE, {
      'highlight': Color(0xFFFFB7DE),
      'splash': Color(0xFFF94CBF),
    }),
    ColorSwatch(0xFF8899A8, {
      'highlight': Color(0xFF8899A8),
      'splash': Color(0xFFA9CAE8),
    }),
    ColorSwatch(0xFFEAD37E, {
      'highlight': Color(0xFFEAD37E),
      'splash': Color(0xFFFFE070),
    }),
    ColorSwatch(0xFF81A56F, {
      'highlight': Color(0xFF81A56F),
      'splash': Color(0xFF7CC159),
    }),
    ColorSwatch(0xFFD7C0E2, {
      'highlight': Color(0xFFD7C0E2),
      'splash': Color(0xFFCA90E5),
    }),
    ColorSwatch(0xFFCE9A9A, {
      'highlight': Color(0xFFCE9A9A),
      'splash': Color(0xFFF94D56),
      'error': Color(0xFF912D2D),
    }),
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

    Category category;
    for (var i = 0; i < _categoryNames.length; i++) {
      category = Category(
        name: _categoryNames[i],
        color: _baseColors[i],
        iconLocation: Icons.cake,
        units: _retrieveUnitList(_categoryNames[i]),
      );

      if (i == 0) {
        _defaultCategory = category;
      }

      _categories.add(category);
    }
  }

  void _onCategoryTap(Category category) {
    setState(() {
      _currentCategory = category;
    });
  }

  Widget _buildCategoryWidgets() {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return CategoryTile(
          category: _categories[index],
          onTap: _onCategoryTap
        );
      },
      itemCount: _categories.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    final categoryView = Padding(
      child: _buildCategoryWidgets(),
      padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 48.0),
    );

    return Backdrop(
      currentCategory: _currentCategory == null ? _defaultCategory : _currentCategory,
      frontPanel: _currentCategory == null ?
        UnitConverter(category: _defaultCategory) : UnitConverter(category: _currentCategory),
      backPanel: categoryView,
      frontTitle: Text("Unit Converter"),
      backTitle: Text("Select a Category"),
    );
  }
}

class CategoryScreen extends StatefulWidget {
  const CategoryScreen();

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}