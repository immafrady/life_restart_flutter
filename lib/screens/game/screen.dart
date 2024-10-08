import 'package:flutter/material.dart';
import 'package:life_restart/screens/game/player_attributes_widget.dart';
import 'package:life_restart/widgets/my_app_bar/widget.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(
        title: "人生进行时",
      ),
      body: Column(
        children: [PlayerAttributesWidget()],
      ),
    );
  }
}
