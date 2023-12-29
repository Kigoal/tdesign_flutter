import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/export.dart';
import '../popup/export.dart';

/// 56.0
const kTdActionSheetActionButtonHeight = 56.0;

class TdActionSheetAction<T> extends StatelessWidget {
  const TdActionSheetAction({
    super.key,
    this.onPressed,
    this.value,
    this.isDefaultAction = false,
    this.isDestructiveAction = false,
    this.icon,
    required this.child,
  });

  /// 点击事件
  final VoidCallback? onPressed;

  /// 标签值
  final T? value;

  /// 是否是默认选项
  final bool isDefaultAction;

  /// 是否是破坏选项
  final bool isDestructiveAction;

  /// 图标
  final Widget? icon;

  /// 子元素
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = TdTheme.of(context);

    Color defaultColor = isDestructiveAction ? theme.errorColor : theme.textColorPrimary;

    return _TdActionSheetActionButton(
      onPressed: () {
        TdPopupPlugin.pop(value);

        onPressed?.call();
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null)
            Padding(
              padding: EdgeInsets.only(right: theme.spacer),
              child: IconTheme(
                data: IconThemeData(
                  size: theme.spacer3,
                  color: defaultColor,
                ),
                child: icon!,
              ),
            ),
          Flexible(
            child: DefaultTextStyle(
              style: theme.fontM.copyWith(
                color: defaultColor,
                fontWeight: isDefaultAction ? FontWeight.w600 : null,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}

class _TdActionSheetActionButton extends StatefulWidget {
  const _TdActionSheetActionButton({
    required this.onPressed,
    required this.child,
  });

  final Widget child;

  final VoidCallback onPressed;

  @override
  State<_TdActionSheetActionButton> createState() => _TdActionSheetActionButtonState();
}

class _TdActionSheetActionButtonState extends State<_TdActionSheetActionButton> {
  bool _tapped = false;

  void _setTapped(bool value) {
    if (_tapped != value) {
      setState(() {
        _tapped = value;
      });
    }
  }

  void _handleTapDown(TapDownDetails details) {
    _setTapped(true);

    _handleHaptic();
  }

  void _handleTapUp(TapUpDetails details) {
    _setTapped(false);
  }

  void _handleTapCancel() {
    _setTapped(false);
  }

  void _handleHaptic() {
    final bool hasSuitableHapticHardware;

    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        hasSuitableHapticHardware = true;
        break;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        hasSuitableHapticHardware = false;
        break;
    }

    if (hasSuitableHapticHardware) {
      HapticFeedback.lightImpact();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = TdTheme.of(context);

    return GestureDetector(
      onTap: widget.onPressed,
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: Container(
        alignment: Alignment.center,
        constraints: const BoxConstraints.expand(
          height: kTdActionSheetActionButtonHeight,
        ),
        padding: EdgeInsets.symmetric(horizontal: theme.spacer2),
        color: _tapped ? theme.backgroundColorContainerActive : theme.backgroundColorContainer,
        child: widget.child,
      ),
    );
  }
}
