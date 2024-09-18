import 'package:flutter/cupertino.dart';

import 'dict/dict.dart';
import 'manager/event.dart';
import 'manager/talent.dart';
import 'property/property.dart';
import 'sources.dart';

// 其实就是原项目的Life类
class CoreDelegate extends ChangeNotifier {
  bool isReady = false;
  final Sources _sources = Sources();

  late final DictStore dictStore; // 总字典
  late final EventManager eventManager;
  late final TalentManager talentManager;

  late final PropertyController propertyController; // 属性？

  // 加载
  initialize() async {
    if (!_sources.isLoaded) {
      await _sources.load();
    }

    dictStore = DictStore.fromJson(source: _sources.data);
    eventManager = EventManager(events: dictStore.events);
    talentManager = TalentManager(talents: dictStore.talents);

    propertyController = PropertyController();
    isReady = true;
    notifyListeners();
  }

  startNewLife() {}
}
