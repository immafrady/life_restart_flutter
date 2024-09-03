import 'package:flutter/material.dart';
import 'package:life_restart/constants/preference_keys.dart' as pk;
import 'package:shared_preferences/shared_preferences.dart';

class ThemeStore extends ChangeNotifier {
  final SharedPreferencesAsync _prefs = SharedPreferencesAsync();

  initialize() async {
    _modeIndex = await _prefs.getInt(pk.themeModeIndex) ?? 0;
    _colorIndex = await _prefs.getInt(pk.themeColorIndex) ?? 0;
    notifyListeners();
  }

  ThemeData get lightTheme => ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(seedColor: currentColor.color),
    useMaterial3: true,
  );

  ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(seedColor: currentColor.color, brightness: Brightness.dark),
    useMaterial3: true,
  );


  // 颜色
  ColorLabel get currentColor => colorLabelList[_colorIndex];
  int _colorIndex = 0;
  void toggleColor() async {
    _colorIndex = (_colorIndex + 1) % colorLabelList.length;
    _prefs.setInt(pk.themeColorIndex, _colorIndex);
    notifyListeners();
  }

  // 模式
  ThemeModeLabel get currentMode => themeModelLabelList[_modeIndex];
  int _modeIndex = 0;
  void toggleDarkMode() async {
    _modeIndex = (_modeIndex + 1) % themeModelLabelList.length;
    _prefs.setInt(pk.themeModeIndex, _modeIndex);
    notifyListeners();
  }
}

enum ColorLabel {
  deepPurple(label: '深紫色', color: Colors.deepPurple),
  blue(label: '蓝色', color: Colors.blue),
  red(label: '红色', color: Colors.red),
  green(label: '绿色', color: Colors.green),
  grey(label: '灰色', color: Colors.grey),
  amber(label: '琥珀色', color: Colors.amber),
  ;

  final String label;
  final Color color;
  const ColorLabel({ required this.label, required this.color });
}
final List<ColorLabel> colorLabelList = ColorLabel.values.toList();

enum ThemeModeLabel {
  system(label: '跟随系统', mode: ThemeMode.system, icon: Icons.brightness_auto_sharp),
  light(label: '明亮模式', mode: ThemeMode.light, icon: Icons.brightness_7_sharp ),
  dark(label: '黑暗模式', mode: ThemeMode.dark, icon: Icons.brightness_2_sharp);

  final String label;
  final ThemeMode mode;
  final IconData icon;
  const ThemeModeLabel({ required this.label, required this.mode, required this.icon });
}
final List<ThemeModeLabel> themeModelLabelList = ThemeModeLabel.values.toList();
