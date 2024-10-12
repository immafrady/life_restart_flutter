import 'package:flutter/material.dart';
import 'package:life_restart/core/core.dart';
import 'package:life_restart/core/types.dart';
import 'package:life_restart/utils/generate_spaced_children.dart';
import 'package:provider/provider.dart';

class PlayerAttributesWidget extends StatelessWidget {
  const PlayerAttributesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CoreDelegate>(builder: (context, core, widget) {
      final theme = Theme.of(context);
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: generateSpacedChildren(
          spacer: const SizedBox(
            width: 5,
          ),
          children: [
            PropertyKey.charm,
            PropertyKey.intelligence,
            PropertyKey.strength,
            PropertyKey.money,
            PropertyKey.spirit,
          ]
              .map(
                (key) => Expanded(
                  child: Card.outlined(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12), // card的默认圆角
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary,
                            ),
                            child: Text(
                              key.desc,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: theme.colorScheme.onPrimary,
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              core.propertyController.record.list.isEmpty
                                  ? core.propertyController.person.attributes[key]!.toString()
                                  : core.propertyController.record.list.last.attributes[key]!.toString(),
                              style: theme.textTheme.bodyLarge,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      );
    });
  }
}
