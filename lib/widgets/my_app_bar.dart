import 'package:flutter/material.dart';

import 'package:life_restart/constants/strings.dart' as strings;

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    super.key,
    this.title = strings.appName
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: Text(title,
          style:
          TextStyle(color: Theme.of(context).colorScheme.inversePrimary)
      )
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}