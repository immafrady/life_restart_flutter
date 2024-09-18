import 'dart:convert';

import 'package:life_restart/utils/parsers.dart';

import './property/person.dart';
import 'types.dart';

typedef Conditions = List<Object>;

Conditions parseConditions(String condition) {
  final Conditions conditions = [];
  final len = condition.length;
  final Conditions stack = [conditions];

  var cursor = 0;

  void catchString(int index) {
    final str = condition.substring(cursor, index).trim();
    cursor = index;
    if (str != '') {
      (stack[0] as Conditions).add(str);
    }
  }

  for (var i = 0; i < len; i++) {
    switch (condition[i]) {
      case '(':
        catchString(i);
        cursor++;
        final Conditions sub = [];
        (stack[0] as Conditions).add(sub);
        stack.insert(0, sub);
      case ')':
        catchString(i);
        cursor++;
        stack.removeAt(0);
      case '|':
      case '&':
        catchString(i);
        catchString(i + 1);
      case ' ':
      default:
        continue;
    }
  }
  catchString(len);
  return conditions;
}

// 从条件中提取最多触发数
int extractMaxTrigger(String condition) {
  final RegExp regAgeCondition = RegExp(r'AGE\?\[([0-9\,]+)\]');
  final matchObj = regAgeCondition.firstMatch(condition);

  if (matchObj == null) {
    return 1;
  }
  final ageList = matchObj.group(1)!.split(',');
  return ageList.length;
}

// 判断数值和条件的结果
bool checkProp(Person person, String condition) {
  RegExpMatch match = RegExp(r"[><!?=]/").firstMatch(condition)!; // 强制有！
  final propertyKey = PropertyKey.parse(condition.substring(0, match.start))!;
  int symbolEnd = condition[match.start + 1] == '=' ? 2 : 1;
  final symbol = condition.substring(match.start, symbolEnd);
  final d = condition.substring(symbolEnd, condition.length);

  final propData = switch (propertyKey.type) {
    PropertyType.attribute => person.getAttribute(propertyKey),
    PropertyType.relation => person.getRelation(propertyKey),
    _ => 0
  };

  if (d.startsWith('[')) {
    final List<int> arrData = jsonDecode(d);
    if (propData is List<int>) {
      // 数组
      return switch (symbol) {
        '?' => propData.any((i) => arrData.contains(i)),
        '!' => !propData.any((i) => arrData.contains(i)),
        _ => false
      };
    } else if (propData is int) {
      // 数字
      return switch (symbol) {
        '?' => arrData.contains(propData),
        '!' => !arrData.contains(propData),
        _ => false
      };
    }
  } else {
    final intData = convertToInt(d);
    if (propData is int) {
      // 数字
      return switch (symbol) {
        '>' => propData > intData,
        '<' => propData < intData,
        '>=' => propData >= intData,
        '<=' => propData <= intData,
        '!=' => propData != intData,
        '=' => propData == intData,
        _ => false
      };
    } else if (propData is List<int>) {
      return switch (symbol) {
        '=' => propData.contains(intData),
        '!=' => !propData.contains(intData),
        _ => false
      };
    }
  }

  return false;
}

// 校验解析后的条件
bool checkParsedConditions(Person person, dynamic conditions) {
  if (conditions is String) {
    return checkProp(person, conditions);
  }
  if (conditions is List<dynamic>) {
    if (conditions.isEmpty) {
      // 0
      return true;
    } else if (conditions.length == 1) {
      // 1
      return checkParsedConditions(person, conditions[0]);
    } else {
      // many
      var ret = checkParsedConditions(person, conditions[0]);
      for (var i = 1; i < conditions.length; i += 2) {
        switch (conditions[i]) {
          case '&':
            if (ret) {
              ret = checkParsedConditions(person, conditions[i + 1]);
            }
          case '|':
            if (ret) {
              return true;
            }
            // todo 潜在out of range问题
            ret = checkParsedConditions(person, conditions[i + 1]);
          default:
            return false;
        }
      }
    }
  }
  return false;
}

bool checkCondition(Person person, String condition) {
  Conditions conditions = parseConditions(condition);
  return checkParsedConditions(person, conditions);
}
