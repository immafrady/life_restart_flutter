import 'package:flutter/material.dart';
import 'package:life_restart/core/core.dart';
import 'package:life_restart/core/types.dart';
import 'package:life_restart/screens/talent_point/point_edit_widget.dart';
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
  // 总点数
  int _totalPoints = 0;

  Map<PropertyKey, int> _map = {
    PropertyKey.charm: 0,
    PropertyKey.strength: 0,
    PropertyKey.intelligence: 0,
    PropertyKey.money: 0
  };

  // 自由点数
  int get _freePoints => _totalPoints - _map.values.reduce((total, curr) => total + curr);

  @override
  void initState() {
    super.initState();
    setState(() {
      final core = Provider.of<CoreDelegate>(context, listen: false);
      final playerStore = Provider.of<PlayerStore>(context, listen: false);
      _totalPoints = widget.initPoint + core.talentManager.getAdditionPoints(playerStore.talentIds);
      if (playerStore.totalPoints < _totalPoints) {
        // 可选的多于上次选择的，直接把值拷过来，让用户和上次玩有关联
        _map = playerStore.pointRecord;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final headlineSmall = Theme.of(context).textTheme.headlineSmall!;
    return Scaffold(
      appBar: const MyAppBar(title: '调整初始属性'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '可用属性点',
                    style: headlineSmall,
                  ),
                  SizedBox(
                    width: headlineSmall.fontSize! * 0.5,
                  ),
                  SizedBox(
                    width: headlineSmall.fontSize! * 2,
                    child: Text(
                      '$_freePoints',
                      textAlign: TextAlign.end,
                      style: headlineSmall,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [PropertyKey.charm, PropertyKey.intelligence, PropertyKey.strength, PropertyKey.money]
                      .map(
                        (propertyKey) => PointEditWidget(
                          propertyKey: propertyKey,
                          value: _map[propertyKey]!,
                          total: _freePoints + _map[propertyKey]!,
                          onChanged: (value) {
                            setState(() {
                              _map[propertyKey] = value;
                            });
                          },
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.casino),
                    label: const Text("随机分配"),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  FilledButton(
                    onPressed: () {},
                    child: const Text('开始新人生'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
