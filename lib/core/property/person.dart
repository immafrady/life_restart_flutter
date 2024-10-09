import 'dart:math';

import '../types.dart';

// 人(记录属性变动)
class Person {
  Person() {
    reset();
  }

  AttributeMap attributes = {};
  RelationMap relations = {};

  void reset() {
    attributes = {
      PropertyKey.age: -1,
      PropertyKey.charm: 0,
      PropertyKey.intelligence: 0,
      PropertyKey.strength: 0,
      PropertyKey.money: 0,
      PropertyKey.spirit: 0,
      PropertyKey.life: 0
    };
    relations = {
      PropertyKey.talent: [],
      PropertyKey.event: [],
    };
  }

  // 数值变更
  change(PropertyKey key, Object value) {
    if (value is List<int>) {
      value.forEach((v) => change(key, v));
    } else if (value is int) {
      if (key.type == PropertyType.attribute) {
        _setAttribute(key, value);
      } else if (key.type == PropertyType.relation) {
        _setRelations(key, value);
      }
    } else {
      print('啥玩意，乱传 $key, $value');
    }
  }

  // 设置属性
  _setAttribute(PropertyKey key, int value) {
    if (key == PropertyKey.random) {
      key = _randomAttribute();
    }
    attributes[key] = (attributes[key] ?? 0) + value;
  }

  // 设置关联
  _setRelations(PropertyKey key, int value) {
    final List<int> list = relations[key]!;
    list.remove(value);
    list.add(value);
  }

  // 取值
  int getAttribute(PropertyKey key) => key.type == PropertyType.attribute ? attributes[key]! : 0;

  List<int> getRelation(PropertyKey key) => key.type == PropertyType.relation ? relations[key]! : [];

  PropertyKey _randomAttribute() {
    final list = attributes.keys.toList();
    return list[Random().nextInt(list.length)];
  }
}
