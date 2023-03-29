import 'package:flutter/material.dart';

class PingTabBar extends StatefulWidget {
  const PingTabBar({
    super.key,
    required this.tabs,
    required this.controller,
  });

  final List<String> tabs;
  final TabController controller;

  @override
  State<PingTabBar> createState() => _PingTabBarState();
}

class _PingTabBarState extends State<PingTabBar> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
