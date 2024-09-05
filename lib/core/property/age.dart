import 'package:life_restart/core/types.dart';

// 年龄控制
class AgeData {
  final Map<int, Age> _ageTree = {};

  AgeData(JSONMap ages) {
    for (var MapEntry(:key, :value) in ages.entries) {
      _ageTree[int.parse(key)] = Age(value['age'], value['event']);
    }
  }

  // 获取年龄相关数据
  Age get(int age) {
    return _ageTree[age]!;
  }
}

class Age {
  final int age;
  final List<(int, double)> event = [];
  final List<int> talent = []; // todo 这个好像是后面拼接上去的？

  Age(String age, List<Object> rawEvent) : age = int.parse(age) {
    for (var e in rawEvent) {
      if (e is int) {
        event.add((e, 1.0));
      } else if (e is String) {
        var pair = e.split('*');
        event.add(switch (pair.length) {
          1 => (int.parse(pair[0]), 1.0),
          _ => (int.parse(pair[0]), double.parse(pair[1])),
        });
      }
    }
  }
}
