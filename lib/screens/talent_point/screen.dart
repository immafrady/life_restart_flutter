import 'package:flutter/material.dart';
import 'package:life_restart/core/core.dart';
import 'package:life_restart/stores/player.dart';
import 'package:life_restart/widgets/my_app_bar/widget.dart';
import 'package:provider/provider.dart';

class TalentPointScreen extends StatefulWidget {
  TalentPointScreen({super.key, required this.initPoint});

  // 总点数
  int initPoint;

  @override
  State<TalentPointScreen> createState() => _TalentPointScreenState();
}

class _TalentPointScreenState extends State<TalentPointScreen> {
  // 可用的总点数
  int _totalPoints = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      _totalPoints = widget.initPoint +
          Provider.of<CoreDelegate>(context, listen: false)
              .talentManager
              .getAdditionPoints(Provider.of<PlayerStore>(context, listen: false).talentIds);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: '选择点数'),
      body: Center(
        child: Column(
          children: [
            Text('选择的id: ${Provider.of<PlayerStore>(context).talentIds}'),
            Text('可用点数: $_totalPoints'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'start',
        onPressed: () {},
        child: const Text('haha'),
      ),
    );
  }
}
