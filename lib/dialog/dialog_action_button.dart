import 'package:flutter/widgets.dart';

import './interface.dart';

class TdDialogActionButton {
  const TdDialogActionButton({
    this.role = TdDialogActionRole.none,
    this.onPressed,
    this.icon,
    required this.title,
  });

  const TdDialogActionButton.submit({
    this.onPressed,
    this.icon,
    required this.title,
  }) : role = TdDialogActionRole.submit;

  const TdDialogActionButton.delete({
    this.onPressed,
    this.icon,
    required this.title,
  }) : role = TdDialogActionRole.delete;

  /// 点击事件
  final VoidCallback? onPressed;

  /// 按钮权限
  final TdDialogActionRole role;

  /// 图标
  final Widget? icon;

  /// 标题
  final Widget title;
}
