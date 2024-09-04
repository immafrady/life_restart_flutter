import 'package:flutter/cupertino.dart';
import 'package:life_restart/core/event.dart';
import 'package:life_restart/core/sources.dart';
import 'package:life_restart/core/types.dart';

// 其实就是原项目的Life类
class CoreDelegate extends ChangeNotifier {
  bool isReady = false;
  final Sources _sources = Sources();

  late EventController eventController; // 事件

  // 加载
  initialize() async {
    if (!_sources.isLoaded) {
      await _sources.load();
    }
    eventController =
        EventController(_sources.data[FileType.events] as JSONMap);
    isReady = true;
    notifyListeners();
  }

  startNewLife() {}
}
