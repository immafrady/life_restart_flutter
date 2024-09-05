import 'package:life_restart/core/property/age.dart';
import 'package:life_restart/core/types.dart';

import 'person.dart';
import 'record.dart';

// 属性控制
class PropertyController {
  final Person person = Person();
  final PlayRecord record = PlayRecord();
  late final AgeData ageData;

  PropertyController(JSONMap ages) {
    ageData = AgeData(ages);
  }

  restart() {
    person.reset();
    record.reset();
    // 还有一个，不知道有啥用 this.effect(person);
  }
}
