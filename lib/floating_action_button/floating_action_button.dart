import 'package:flutter/material.dart';

import '../theme/export.dart';
import '../button/export.dart';

class TdFloatingActionButton extends StatelessWidget {
  const TdFloatingActionButton({
    super.key,
    required this.onPressed,
    required this.child,
  }) : _extendedLabel = null;

  const TdFloatingActionButton.extended({
    super.key,
    required this.onPressed,
    Widget? icon,
    required Widget label,
  })  : child = icon,
        _extendedLabel = label;

  /// 点击事件
  final VoidCallback onPressed;

  /// 子元素
  final Widget? child;

  /// 扩展标签
  final Widget? _extendedLabel;

  @override
  Widget build(BuildContext context) {
    final theme = TdTheme.of(context);

    final EdgeInsets padding;
    if (_extendedLabel != null) {
      padding = EdgeInsets.symmetric(
        vertical: theme.spacer1,
        horizontal: theme.spacer2 + theme.spacer / 2,
      );
    } else {
      padding = EdgeInsets.all(theme.spacer1);
    }

    return TdRawButton(
      onPressed: onPressed,
      padding: padding,
      borderRadius: theme.radiusRound,
      boxShadow: theme.shadow2,
      textStyle: theme.fontM,
      iconTheme: IconThemeData(size: theme.spacer3),
      textColor: theme.fontWhite1,
      backgroundColor: theme.brandColor,
      actionBackgroundColor: theme.brandColorActive,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (child != null) child!,
          if (_extendedLabel != null)
            Padding(
              padding: EdgeInsets.only(left: theme.spacer / 2),
              child: _extendedLabel,
            ),
        ],
      ),
    );
  }
}
