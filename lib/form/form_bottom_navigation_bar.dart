import 'package:flutter/widgets.dart';

import '../theme/export.dart';
import '../divider/export.dart';
import '../button/export.dart';

class TdFormBottomNavigationBar extends StatelessWidget {
  const TdFormBottomNavigationBar({
    super.key,
    this.submit = const Text('提交'),
    required this.onSubmit,
    this.reset = const Text('重置'),
    required this.onReset,
  });

  /// 提交按钮
  final Widget submit;

  /// 点击提交事件
  final GestureTapCallback onSubmit;

  /// 重置按钮
  final Widget reset;

  /// 点击重置事件
  final GestureTapCallback onReset;

  @override
  Widget build(BuildContext context) {
    final theme = TdTheme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const TdDivider(indent: 0.0),
        Container(
          padding: EdgeInsets.symmetric(
            vertical: theme.spacer1,
            horizontal: theme.spacer2,
          ),
          color: theme.backgroundColorContainer,
          child: SafeArea(
            top: false,
            child: Row(
              children: [
                Expanded(
                  child: TdButton(
                    onPressed: onReset,
                    child: reset,
                  ),
                ),
                SizedBox(width: theme.spacer2),
                Expanded(
                  child: TdButton.primary(
                    onPressed: onSubmit,
                    child: submit,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
