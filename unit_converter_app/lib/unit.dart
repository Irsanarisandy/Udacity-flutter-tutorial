// @required is defined in the meta.dart package
import 'package:meta/meta.dart';

class Unit {
  const Unit({
    @required this.name,
    @required this.conversion,
  })  : assert(name != null),
        assert(conversion != null);

  final String name;
  final double conversion;

  /// Creates a [Unit] from a JSON object.
  Unit.fromJson(Map jsonMap)
      : name = jsonMap['name'],
        conversion = jsonMap['conversion'].toDouble(),
        assert(name != null),
        assert(conversion != null);
}