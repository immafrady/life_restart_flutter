import 'package:life_restart/core/types.dart';
import 'package:life_restart/utils/parsers.dart';

class Age {
  late final int age;
  late final List<(int, double)> event = [];
  late final List<int> talent = []; // todo 这个好像是后面拼接上去的？

  Age.fromJson(JSONMap json) {
    age = convertToInt(json['age']);
    final List<dynamic> rawEvent = json['event'];
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
