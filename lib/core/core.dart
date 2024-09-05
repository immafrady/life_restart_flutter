import 'package:flutter/cupertino.dart';
import 'package:life_restart/core/event.dart';
import 'package:life_restart/core/property/property.dart';
import 'package:life_restart/core/sources.dart';
import 'package:life_restart/core/types.dart';

// 其实就是原项目的Life类
class CoreDelegate extends ChangeNotifier {
  bool isReady = false;
  final Sources _sources = Sources();

  late final EventController eventController; // 事件
  late final PropertyController propertyController; // 属性？

  // 加载
  initialize() async {
    if (!_sources.isLoaded) {
      await _sources.load();
    }
    eventController =
        EventController(_sources.data[FileType.events] as JSONMap);
    propertyController =
        PropertyController(_sources.data[FileType.ages] as JSONMap);
    isReady = true;
    notifyListeners();
  }

  startNewLife() {}
}
