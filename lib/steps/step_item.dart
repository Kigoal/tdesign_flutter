import 'package:flutter/widgets.dart';

import './interface.dart';

class TdStepItem {
  const TdStepItem({
    this.status,
    required this.title,
    this.content,
    this.icon,
  });

  /// 当前步骤的状态
  final TdStepStatus? status;

  /// 标题
  final Widget title;

  /// 步骤描述
  final Widget? content;

  /// 自定义图标
  final Widget? icon;
}
