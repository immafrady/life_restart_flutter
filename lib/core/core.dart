import 'package:flutter/cupertino.dart';
import 'package:life_restart/core/property/property.dart';
import 'package:life_restart/core/sources.dart';

import 'dict/dict.dart';

// 其实就是原项目的Life类
class CoreDelegate extends ChangeNotifier {
  bool isReady = false;
  final Sources _sources = Sources();

  late final DictStore dictStore; // 总字典

  late final PropertyController propertyController; // 属性？

  // 加载
  initialize() async {
    if (!_sources.isLoaded) {
      await _sources.load();
    }

    dictStore = DictStore.fromJson(source: _sources.data);

    propertyController = PropertyController();
    isReady = true;
    notifyListeners();
  }

  startNewLife() {}
}
