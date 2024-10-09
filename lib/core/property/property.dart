import '../types.dart';
import 'person.dart';
import 'record.dart';

// 属性控制
class PropertyController {
  final Person person = Person();
  final PlayRecord record = PlayRecord();

  PropertyController();

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

  // 添加记录
  void setRecord() {
    record.add(person);
  }
}
