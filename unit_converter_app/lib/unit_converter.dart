import 'package:flutter/material.dart';
// @required is defined in the meta.dart package
import 'package:meta/meta.dart';
import 'category.dart';
import 'unit.dart';

final _padding = EdgeInsets.all(16.0);

class _UnitConverterState extends State<UnitConverter> {
  double _inputValue;
  Unit _inputUnit;
  String _outputValue = '';
  Unit _outputUnit;
  List<DropdownMenuItem> _unitMenuItems;
  bool _invalidInput = false;
  // Ensures that the input value persists
  final _inputKey = GlobalKey(debugLabel: 'inputText');

  void _setDefaults() {
    setState(() {
      _inputUnit = widget.category.units[0];
      _outputUnit = widget.category.units[1];
    });
  }

  void _createDropdownMenuItems() {
    var newItems = <DropdownMenuItem>[];

    for (var unit in widget.category.units) {
      newItems.add(DropdownMenuItem(
        value: unit.name,
        child: Container(
          child: Text(
            unit.name,
            softWrap: true
          ),
        )
      ));
    }

    setState(() {
      _unitMenuItems = newItems;
    });
  }

  @override
  void initState() {
    super.initState();
    _setDefaults();
    _createDropdownMenuItems();
  }

  @override
  void didUpdateWidget(UnitConverter old) {
    super.didUpdateWidget(old);
    if (old.category != widget.category) {
      _setDefaults();
      _createDropdownMenuItems();
    }
  }

  String _format(double conversion) {
    var outputNum = conversion.toStringAsPrecision(7);
    if (outputNum.contains('.') && outputNum.endsWith('0')) {
      var i = outputNum.length - 1;
      while (outputNum[i] == '0') {
        i -= 1;
      }
      outputNum = outputNum.substring(0, i + 1);
    }
    if (outputNum.endsWith('.')) {
      return outputNum.substring(0, outputNum.length - 1);
    }
    return outputNum;
  }

  void _resultOutput() {
    setState(() {
      _outputValue = _format(_inputValue * (_outputUnit.conversion / _inputUnit.conversion));
    });
  }

  void _updateInputValue(String input) {
    setState(() {
      if (input == null || input.isEmpty) {
        _outputValue = '';
      } else {
        try {
          _inputValue = double.parse(input);
          _invalidInput = false;
          _resultOutput();
        } on Exception catch (err) {
          print("Error: $err");
          _invalidInput = true;
        }
      }
    });
  }

  Unit _getUnitName(String unitName) {
    return widget.category.units.firstWhere(
      (Unit unit) {
        return unit.name == unitName;
      },
      orElse: null
    );
  }

  void _updateFromUnit(dynamic unitName) {
    setState(() {
      _inputUnit = _getUnitName(unitName);
    });
    if (_inputValue != null) {
      _resultOutput();
    }
  }

  void _updateToUnit(dynamic unitName) {
    setState(() {
      _outputUnit = _getUnitName(unitName);
    });
    if (_inputValue != null) {
      _resultOutput();
    }
  }

  Widget _createDropdown(String currentUnit, ValueChanged<dynamic> onChange) {
    return Container(
      margin: EdgeInsets.only(top: 16.0),
      padding: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        // Fill color inside container (not text color)
        color: Colors.grey[50],
        border: Border.all(
          color: Colors.grey[400],
        ),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          // Background color of DropdownButtonMenuItem
          canvasColor: Colors.grey[50]
        ),
        child: DropdownButtonHideUnderline(
          child: ButtonTheme(
            // If set true, DropdownButton menu's width will match the button's width
            alignedDropdown: true,
            child: DropdownButton(
              value: currentUnit,
              items: _unitMenuItems,
              onChanged: onChange,
              style: Theme.of(context).textTheme.title,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final inputWidget = Padding(
      padding: _padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextField(
            key: _inputKey,
            keyboardType: TextInputType.number,
            onChanged: _updateInputValue,
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.display1,
            decoration: InputDecoration(
                labelText: 'Input',
                labelStyle: Theme.of(context).textTheme.display1,
                errorText: _invalidInput ? 'Invalid number!' : null,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0.0)
                )
            ),
          ),
          _createDropdown(_inputUnit.name, _updateFromUnit)
        ],
      )
    );

    final comparisonWidget = RotatedBox(
      quarterTurns: 1,
      child: Icon(
        Icons.compare_arrows,
        size: 40.0,
      ),
    );

    final outputWidget = Padding(
      padding: _padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          InputDecorator(
            decoration: InputDecoration(
                labelText: 'Output',
                labelStyle: Theme.of(context).textTheme.display1,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0.0)
                )
            ),
            child: Text(
              _outputValue,
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.display1,
            ),
          ),
          _createDropdown(_outputUnit.name, _updateToUnit)
        ],
      )
    );

    final converter = ListView(
      children: [
        inputWidget,
        comparisonWidget,
        outputWidget,
      ],
    );

    return Padding(
      padding: _padding,
      child: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          if (orientation == Orientation.portrait) {
            return converter;
          }
          return Center(
            child: Container(
              width: 450.0,
              child: converter,
            ),
          );
        }
      ),
    );
  }
}

class UnitConverter extends StatefulWidget {
  const UnitConverter({
    Key key,
    @required this.category,
  }) : assert(category != null),
        super(key: key);

  final Category category;

  @override
  _UnitConverterState createState() => _UnitConverterState();
}