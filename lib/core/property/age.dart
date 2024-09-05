import 'package:life_restart/core/types.dart';

// 年龄控制
class AgeController {
  final Map<int, Age> ageTree = {};

  AgeController(JSONMap ages) {
    for (var MapEntry(:key, :value) in ages.entries) {
      ageTree[int.parse(key)] = Age(value['age'], value['event']);
    }
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
