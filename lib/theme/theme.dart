import 'package:flutter/material.dart';

import './theme_data.dart';

class TdTheme extends StatelessWidget {
  const TdTheme({
    super.key,
    required this.data,
    required this.child,
  });

  final TdThemeData data;

  final Widget child;

  static TdThemeData of(BuildContext context) {
    return Theme.of(context).extension<TdThemeData>() ?? TdThemeData.fallback();
  }

  @override
  Widget build(BuildContext context) {
    return child;
  }
}