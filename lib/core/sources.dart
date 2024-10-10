import 'dart:convert';

import 'package:flutter/services.dart';

import 'dict/dict.dart';
import 'types.dart';

class Sources {
  Sources._();

  // 单例
  static final Sources _instance = Sources._();

  factory Sources() => _instance;

  late final DictStore dictStore; // 总字典

  bool isLoaded = false;

  Future<JSONMap> _loadJsonFromAssets(String fileName) async {
    String jsonString = await rootBundle.loadString('assets/data/$fileName.json');
    return jsonDecode(jsonString);
  }

  Future<void> load() async {
    final data = <FileType, JSONMap>{};
    for (var v in FileType.values) {
      data[v] = await _loadJsonFromAssets(v.keyPath);
    }
    dictStore = DictStore.fromJson(source: data);
    isLoaded = true;
  }
}

enum FileType {
  ages('ages'),
  events('events'),
  talents('talents'),
  ;

  final String keyPath;

  const FileType(this.keyPath);
}
