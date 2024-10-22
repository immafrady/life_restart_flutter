import 'package:flutter/material.dart';
import 'package:life_restart/core/core.dart';
import 'package:life_restart/core/summary.dart';
import 'package:life_restart/core/types.dart';
import 'package:provider/provider.dart';

class ResultListWidget extends StatelessWidget {
  const ResultListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CoreDelegate>(
      builder: (context, core, widget) {
        final records = core.propertyController.record.list;
        final charmScore = calcScore(records, PropertyKey.charm);
        final moneyScore = calcScore(records, PropertyKey.money);
        final spiritScore = calcScore(records, PropertyKey.spirit);
        final ageScore = calcScore(records, PropertyKey.age);
        final intelScore = calcScore(records, PropertyKey.intelligence);
        final strengthScore = calcScore(records, PropertyKey.strength);
        final summaryScore = charmScore + intelScore + strengthScore + moneyScore + spiritScore * 2 + ageScore ~/ 2;
        return Column(
          children: [
            _InfoCard(
              color: Theme.of(context).colorScheme.surface,
              onColor: Theme.of(context).colorScheme.onSurface,
              desc: '属性',
              score: '得分',
              judge: '评价',
              isBold: true,
            ),
            ...<(PropertyKey, int)>[
              (PropertyKey.charm, charmScore),
              (PropertyKey.intelligence, intelScore),
              (PropertyKey.strength, strengthScore),
              (PropertyKey.money, moneyScore),
              (PropertyKey.spirit, spiritScore),
              (PropertyKey.age, ageScore),
              (PropertyKey.summary, summaryScore),
            ].map((pair) {
              final (key, score) = pair;
              final (:judge, :grade) = getSummary(key, score);
              final (:color, :onColor) = getGradeColor(grade);
              return _InfoCard(
                color: color,
                onColor: Colors.white,
                desc: key.desc,
                score: '$score',
                judge: judge,
                isBold: key == PropertyKey.summary,
              );
            })
          ],
        );
      },
    );
  }
}

({Color color, Color onColor}) getGradeColor(Grade grade) {
  return switch (grade) {
    Grade.i => (color: Colors.blueGrey, onColor: Colors.blueGrey[100]!),
    Grade.ii => (color: Colors.blueAccent, onColor: Colors.blueAccent[100]!),
    Grade.iii => (color: Colors.deepPurpleAccent, onColor: Colors.deepPurpleAccent[100]!),
    Grade.iv => (color: Colors.orangeAccent, onColor: Colors.orangeAccent[100]!),
  };
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.desc,
    required this.score,
    required this.judge,
    required this.color,
    required this.onColor,
    required this.isBold,
  });

  final Color color;
  final Color onColor;
  final String desc;
  final String score;
  final String judge;
  final bool isBold;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.bodyLarge!.copyWith(color: onColor);
    final textStyle = isBold ? const TextStyle(fontWeight: FontWeight.bold) : null;
    return Card(
      color: color,
      surfaceTintColor: Theme.of(context).colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
        child: DefaultTextStyle(
          style: textTheme,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(desc, style: textStyle),
              Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: textTheme.fontSize! * 4,
                    child: Text(score, style: textStyle),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    width: textTheme.fontSize! * 4,
                    child: Text(judge, style: textStyle),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
