import 'package:flutter/material.dart';

import '../theme/export.dart';
import '../button/export.dart';
import 'dialog_action_button.dart';
import './dialog_notification.dart';
import './interface.dart';

const kTdDialogActionConfirm = Text('确定');
const kTdDialogActioncancel = Text('取消');

class TdDialogActions extends StatelessWidget {
  const TdDialogActions({
    super.key,
    this.axis,
    required this.children,
  });

  TdDialogActions.confirm({
    super.key,
    this.axis,
    Widget confirm = kTdDialogActionConfirm,
    VoidCallback? onConfirm,
  }) : children = [
          TdDialogActionButton.submit(
            onPressed: onConfirm,
            title: confirm,
          ),
        ];

  TdDialogActions.cancel({
    super.key,
    this.axis,
    Widget cancel = kTdDialogActioncancel,
    VoidCallback? onCancel,
  }) : children = [
          TdDialogActionButton(
            onPressed: onCancel,
            title: cancel,
          ),
        ];

  TdDialogActions.confirmAndCancel({
    super.key,
    this.axis,
    Widget confirm = kTdDialogActionConfirm,
    VoidCallback? onConfirm,
    Widget cancel = kTdDialogActioncancel,
    VoidCallback? onCancel,
  }) : children = [
          TdDialogActionButton.submit(
            onPressed: onConfirm,
            title: confirm,
          ),
          TdDialogActionButton(
            onPressed: onCancel,
            title: cancel,
          ),
        ];

  /// 布局方向
  final Axis? axis;

  /// 子元素
  final List<TdDialogActionButton> children;

  /// 获取当前状态的布局方向
  Axis get _currentAxis {
    return axis != null
        ? axis!
        : children.length <= 2
            ? Axis.horizontal
            : Axis.vertical;
  }

  Widget _buildButton(BuildContext context, TdDialogActionButton item) {
    return TdButton(
      onPressed: () {
        item.onPressed?.call();

        TdDialogNotification(item: item).dispatch(context);
      },
      type: switch (item.role) {
        TdDialogActionRole.none => TdButtonType.light,
        TdDialogActionRole.submit => TdButtonType.primary,
        TdDialogActionRole.delete => TdButtonType.danger,
      },
      size: TdButtonSize.medium,
      child: item.title,
    );
  }

  Widget _buildHorizontal(BuildContext context) {
    final theme = TdTheme.of(context);

    List<Widget> list = [];

    for (var i = 0; i < children.length; i++) {
      if (i != 0) {
        list.add(SizedBox(width: theme.spacer2));
      }

      list.add(Expanded(
        child: _buildButton(context, children[i]),
      ));
    }

    return Row(
      children: list.reversed.toList(),
    );
  }

  Widget _buildVertical(BuildContext context) {
    final theme = TdTheme.of(context);

    List<Widget> list = [];

    for (var i = 0; i < children.length; i++) {
      if (i != 0) {
        list.add(SizedBox(height: theme.spacer1));
      }

      list.add(_buildButton(context, children[i]));
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: list,
    );
  }

  @override
  Widget build(BuildContext context) {
    return switch (_currentAxis) {
      Axis.horizontal => _buildHorizontal(context),
      Axis.vertical => _buildVertical(context),
    };
  }
}
