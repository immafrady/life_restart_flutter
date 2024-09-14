import 'person.dart';
import 'record.dart';

// 属性控制
class PropertyController {
  final Person person = Person();
  final PlayRecord record = PlayRecord();

  PropertyController();

  restart() {
    person.reset();
    record.reset();
    // 还有一个，不知道有啥用 this.effect(person);
  }
}
