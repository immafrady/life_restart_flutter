import 'package:flutter/material.dart';

typedef SFC = ScaffoldFeatureController<MaterialBanner, MaterialBannerClosedReason>;

enum AlertType {
  success(color: Colors.green, iconData: Icons.check_circle_rounded),
  warning(color: Colors.orange, iconData: Icons.warning_rounded),
  error(color: Colors.red, iconData: Icons.error_rounded),
  info(color: Colors.grey, iconData: Icons.info_rounded);

  const AlertType({required this.color, required this.iconData});

  final MaterialColor color;
  final IconData iconData;
}

class MyMaterialBanner {
  static final MyMaterialBanner _instance = MyMaterialBanner._();

  MyMaterialBanner._();

  factory MyMaterialBanner.of(BuildContext context) {
    _instance._context = context;
    return _instance;
  }

  late BuildContext _context;
  SFC? _scaffoldMessengerState;

  SFC showMaterialBanner(
    MaterialBanner mb, {
    Duration? timeout,
  }) {
    close();

    _scaffoldMessengerState = ScaffoldMessenger.of(_context).showMaterialBanner(mb);

    if (timeout != null) {
      Future.delayed(timeout, () {
        close();
      });
    }
    return _scaffoldMessengerState!;
  }

  close() {
    _scaffoldMessengerState?.close();
    _scaffoldMessengerState = null;
  }

  SFC showMessage(
    String msg, {
    Duration timeout = const Duration(milliseconds: 2000),
    AlertType type = AlertType.info,
  }) {
    return showMaterialBanner(
        MaterialBanner(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          leading: Icon(
            type.iconData,
            color: type.color[500],
          ),
          content: Text(
            msg,
            style: TextStyle(
              color: type.color[900],
            ),
          ),
          backgroundColor: type.color[100],
          actions: const [
            Text(""),
          ],
        ),
        timeout: timeout);
  }
}
