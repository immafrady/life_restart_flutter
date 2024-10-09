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
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: generateSpacedChildren(
            spacer: const SizedBox(
              width: 10,
            ),
            children: [
              PropertyKey.charm,
              PropertyKey.intelligence,
              PropertyKey.strength,
              PropertyKey.money,
              PropertyKey.spirit,
            ]
                .map(
                  (key) => Container(
                    width: theme.textTheme.bodyLarge!.fontSize! * 4,
                    decoration: BoxDecoration(
                      border: const Border.fromBorderSide(BorderSide(
                        color: Color(0xFFa7a7a7),
                      )),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary,
                          ),
                          child: Text(
                            key.desc,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: theme.colorScheme.inversePrimary,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            core.propertyController.person.attributes[key]!.toString(),
                            style: theme.textTheme.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      );
    });
  }
}
