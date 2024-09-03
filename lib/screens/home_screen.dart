import 'package:flutter/material.dart';
import 'package:life_restart/constants/strings.dart' as strings;
import 'package:life_restart/stores/theme.dart';
import 'package:life_restart/widgets/my_app_bar.dart';
import 'package:provider/provider.dart';



class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('这垃圾人生一秒也不想待了'),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {

                },
                child: const Text('立即重开')
              )
            ],
          ),
        )
      ),
      floatingActionButton: Consumer<ThemeStore>(
        builder: (context, themeStore, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                onPressed: () {
                  themeStore.toggleColor();
                },
                tooltip: '切换颜色',
                child: Text(themeStore.currentColor.label),
              ),
              const SizedBox(width: 10),
              FloatingActionButton(
                onPressed: () {
                  themeStore.toggleDarkMode();
                },
                tooltip: themeStore.currentMode.label,
                child: Icon(themeStore.currentMode.icon),
              ),
            ],
          );
        }
      )
    );
  }

}