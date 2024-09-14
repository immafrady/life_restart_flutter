import 'package:life_restart/core/property/person.dart';
import 'package:life_restart/core/types.dart';

// 记录每一岁
class PlayRecord {
  List<Map<PropertyKey, int>> _list = [];

  static const List<PropertyKey> _propertyKeyList = [
    PropertyKey.age,
    PropertyKey.charm,
    PropertyKey.intelligence,
    PropertyKey.strength,
    PropertyKey.money,
    PropertyKey.spirit
  ];

  // 重置
  void reset() => _list = [];

  // 添加记录
  void add(Person p) {
    final Map<PropertyKey, int> map = {};
    for (var key in _propertyKeyList) {
      map[key] = p.getAttribute(key);
    }
    _list.add(map);
  }

  // 获取完整记录
  List<Map<PropertyKey, int>> get list => List.unmodifiable(_list);

  // 获取最新记录
  Map<PropertyKey, int> get lastRecord => list.last;
}
