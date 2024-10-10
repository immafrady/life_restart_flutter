import '../dict/age.dart';
import '../dict/data_dict.dart';
import '../types.dart';
import 'person.dart';
import 'record.dart';

// 属性控制
class PropertyController {
  final Person person = Person();
  final PlayRecord record = PlayRecord();
  final DataDict<Age> ages;

  PropertyController({required this.ages});

  restart({required AttributeMap attributes, required RelationMap relations}) {
    person.reset();
    record.reset();
    applyEffect({...attributes, ...relations});
  }

  // 是否结束
  bool isEnd() {
    return person.attributes[PropertyKey.life]! < 1;
  }

  // 能力变动
  void applyEffect(Map<PropertyKey, dynamic> map) {
    for (var MapEntry(:key, :value) in map.entries) {
      person.change(key, value);
    }
  }

  // 下一岁
  Age ageNext() {
    person.change(PropertyKey.age, 1);
    final age = person.getAttribute(PropertyKey.age);
    return ages.get(age);
  }
}
