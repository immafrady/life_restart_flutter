import 'package:flutter/material.dart';
import 'package:life_restart/core/core.dart';
import 'package:life_restart/widgets/talent_list/widget.dart';
import 'package:provider/provider.dart';

import '../../widgets/my_app_bar/widget.dart';

class TalentSelectScreen extends StatefulWidget {
  const TalentSelectScreen({super.key});

  @override
  State<StatefulWidget> createState() => _TalentSelectState();
}

class _TalentSelectState extends State<TalentSelectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: "天赋抽卡",
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: TalentListWidget(
                  talentPool: Provider.of<CoreDelegate>(context)
                      .talentManager
                      .sortedTalents,
                  max: 3),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: () {}, child: Text("选择超级人生")),
                  const SizedBox(width: 20),
                  ElevatedButton(onPressed: () {}, child: Text("选择三个")),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
