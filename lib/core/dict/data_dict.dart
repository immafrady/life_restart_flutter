import '../types.dart';

class DataDict<T> {
  final Map<int, T> _tree = {};

  DataDict.fromJson(JSONMap map, T Function(JSONMap) entryConstructor) {
    for (var MapEntry(:key, :value) in map.entries) {
      _tree[int.parse(key)] = entryConstructor(value);
    }
  }

  T get(int id) {
    return _tree[id]!;
  }
}
