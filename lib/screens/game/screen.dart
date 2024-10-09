import 'package:flutter/material.dart';
import 'package:life_restart/core/core.dart';
import 'package:life_restart/core/dict/talent.dart';
import 'package:life_restart/screens/game/player_attributes_widget.dart';
import 'package:life_restart/stores/player.dart';
import 'package:life_restart/widgets/my_app_bar/widget.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final core = Provider.of<CoreDelegate>(context, listen: false);
      final player = Provider.of<PlayerStore>(context, listen: false);
      setState(() {
        replaceList = core.start(attributes: player.pointRecord, talentIds: player.talentIds);
      });
    });
  }

  // 天赋替换列表 List<(替换前,替换后)>
  List<(Talent, Talent)> replaceList = [];

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
