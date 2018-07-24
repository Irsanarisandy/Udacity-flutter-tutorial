import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'category.dart';
import 'category_tile.dart';
import 'unit_converter.dart';
import 'unit.dart';
import 'backdrop.dart';

class _CategoryScreenState extends State<CategoryScreen> {
  final _categories = <Category>[];
  Category _defaultCategory;
  Category _currentCategory;

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

  // We use didChangeDependencies() so that we can wait for our JSON asset to be
  // loaded in (async).
  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    if (_categories.isEmpty) {
      await _retrieveLocalCategories();
    }
  }

  // Retrieves a list of [Categories] and their [Unit]s
  Future<void> _retrieveLocalCategories() async {
    final json = DefaultAssetBundle.of(context).loadString('assets/data/regular_units.json');
    final data = JsonDecoder().convert(await json);
    if (data is! Map) {
      throw ('Data retrieved from API is not a Map');
    }
    var categoryIndex = 0;
    Category category;
    for (var key in data.keys) {
      final List<Unit> units = data[key].map<Unit>(
        (dynamic data) => Unit.fromJson(data)
      ).toList();

      category = Category(
        name: key,
        color: _baseColors[categoryIndex],
        iconLocation: Icons.cake,
        units: units,
      );

      setState(() {
        if (categoryIndex == 0) {
          _defaultCategory = category;
        }
        _categories.add(category);
      });
      categoryIndex++;
    }
  }

  void _onCategoryTap(Category category) {
    setState(() {
      _currentCategory = category;
    });
  }

  Widget _buildCategoryWidgets(Orientation deviceOrientation) {
    if (deviceOrientation == Orientation.portrait) {
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
    return GridView.count(
      crossAxisCount: 2,  // No. of category per row
      childAspectRatio: 3.0,  // Size of category object (hint: press and hold on the category)
      children: _categories.map((Category category) {
        return CategoryTile(
          category: category,
          onTap: _onCategoryTap,
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    final categoryView = Padding(
      child: _buildCategoryWidgets(MediaQuery.of(context).orientation),
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