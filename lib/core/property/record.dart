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
    required List<Talent> talent,
    required List<Event> event,
  }) {
    final Map<PropertyKey, int> attributes = {};
    for (var key in _propertyKeyList) {
      attributes[key] = person.getAttribute(key);
    }
    final record = AgeRecord(talents: talent, events: event, attributes: attributes);
    _list.add(record);
    return record;
  }

  // 获取完整记录
  List<AgeRecord> get list => List.unmodifiable(_list);
}

class AgeRecord {
  final List<Talent> talents;
  final List<Event> events;
  final Map<PropertyKey, int> attributes;

  int get age => attributes[PropertyKey.age]!;

  const AgeRecord({
    required this.talents,
    required this.events,
    required this.attributes,
  });
}
