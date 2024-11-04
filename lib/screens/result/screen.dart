import 'package:flutter/material.dart';
import 'package:life_restart/core/core.dart';
import 'package:life_restart/screens/result/result_list_widget.dart';
import 'package:life_restart/screens/talent_select/screen.dart';
import 'package:life_restart/stores/player.dart';
import 'package:life_restart/widgets/my_app_bar/widget.dart';
import 'package:life_restart/widgets/my_material_banner/widget.dart';
import 'package:life_restart/widgets/talent_list/widget.dart';
import 'package:provider/provider.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final Set<int> _selectedIds = {};

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<PlayerStore>(context, listen: false);
    final core = Provider.of<CoreDelegate>(context, listen: false);

    return Scaffold(
      appBar: const MyAppBar(
        title: '人生总结',
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const ResultListWidget(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Center(
                child: Text(
                  '天赋, 你可以选一个, 下辈子还能抽到',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
            Expanded(
              child: TalentListWidget(
                talentPool: store.talentIds.map((id) => core.talentManager.talents.get(id)).toList(),
                selectedIds: _selectedIds,
                onSelect: (id) {
                  setState(() {
                    _selectedIds.clear();
                    _selectedIds.add(id);
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    icon: const Icon(Icons.home),
                    label: const Text("回到首页"),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      if (_selectedIds.isEmpty) {
                        MyMaterialBanner.of(context).showMessage(
                          '请至少选择一个天赋',
                          type: AlertType.warning,
                        );
                      } else {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => TalentSelectScreen.restartNormalMode(
                              selectedId: _selectedIds.first,
                            ),
                          ),
                          (Route<dynamic> route) => route.isFirst,
                        );
                      }
                    },
                    icon: const Icon(Icons.redo),
                    label: const Text("再次重开"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
