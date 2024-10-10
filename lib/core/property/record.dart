import 'package:life_restart/core/property/person.dart';
import 'package:life_restart/core/types.dart';

import '../dict/event.dart';
import '../dict/talent.dart';

// 记录每一岁
class PlayRecord {
  final List<AgeRecord> _list = [];

  static const List<PropertyKey> _propertyKeyList = [
    PropertyKey.age,
    PropertyKey.charm,
    PropertyKey.intelligence,
    PropertyKey.strength,
    PropertyKey.money,
    PropertyKey.spirit
  ];

  // 重置
  void reset() {
    _list.clear();
  }

  // 添加记录
  AgeRecord add({
    required Person person,
    List<Talent>? talent,
    List<Event>? event,
  }) {
    final Map<PropertyKey, int> attributes = {};
    for (var key in _propertyKeyList) {
      attributes[key] = person.getAttribute(key);
    }
    final record = AgeRecord(talent: talent ?? [], event: event ?? [], attributes: attributes);
    _list.add(record);
    return record;
  }

  // 获取完整记录
  List<Map<PropertyKey, int>> get list => List.unmodifiable(_list);

  // 获取最新记录
  Map<PropertyKey, int> get lastRecord => list.last;
}

class AgeRecord {
  final List<Talent>? talent;
  final List<Event>? event;
  final Map<PropertyKey, int> attributes;

  int get age => attributes[PropertyKey.age]!;

  const AgeRecord({
    required this.talent,
    required this.event,
    required this.attributes,
  });
}
