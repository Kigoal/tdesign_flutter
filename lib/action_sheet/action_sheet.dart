import 'dart:async';

import 'package:flutter/material.dart';

import '../theme/export.dart';
import '../popup/export.dart';
import '../divider/export.dart';
import './action_sheet_action.dart';

const kTdActionSheetMaxCount = 6;

class TdActionSheet<T> extends StatelessWidget {
  const TdActionSheet({
    super.key,
    this.message,
    required this.actions,
  });

  /// 提示信息
  final Widget? message;

  /// 子元素
  final List<TdActionSheetAction<T>> actions;

  @override
  Widget build(BuildContext context) {
    final theme = TdTheme.of(context);

    Widget? messageWidget;
    if (message != null) {
      messageWidget = Padding(
        padding: EdgeInsets.symmetric(
          vertical: theme.spacer1,
          horizontal: theme.spacer2,
        ),
        child: DefaultTextStyle(
          style: theme.fontBase.copyWith(color: theme.textColorPlaceholder),
          child: message!,
        ),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (messageWidget != null) ...[
          messageWidget,
          TdDivider(
            indent: 0.0,
            color: theme.grayColor1,
          ),
        ],
        _TdActionSheetList(
          actions: actions,
        ),
        TdDivider(
          indent: 0.0,
          height: theme.spacer,
          thickness: theme.spacer,
        ),
        TdActionSheetAction(
          onPressed: () {
            //
          },
          isDefaultAction: true,
          child: const Text('取消'),
        ),
      ],
    );
  }
}

class _TdActionSheetList extends StatelessWidget {
  const _TdActionSheetList({
    required this.actions,
  });

  /// 子元素
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final List<Widget> list = [];

    for (var i = 0; i < actions.length; i++) {
      if (i != 0) {
        list.add(const TdDivider(indent: 0.0));
      }

      list.add(actions[i]);
    }

    Widget result = Column(
      children: list,
    );

    /// 数量超过上限时使用滚动条方式
    if (actions.length > kTdActionSheetMaxCount) {
      result = SizedBox(
        height: kTdActionSheetActionButtonHeight * kTdActionSheetMaxCount + 0.5 * (kTdActionSheetMaxCount - 1),
        child: SingleChildScrollView(
          child: result,
        ),
      );
    }

    return result;
  }
}

class TdActionSheetPlugin {
  /// 弹出选择框
  static Future<T?> open<T>({
    Widget? message,
    required List<TdActionSheetAction<T>> actions,
  }) {
    return TdPopupPlugin.open<T>(
      enableDrag: false,
      builder: (context) {
        return TdActionSheet<T>(
          message: message,
          actions: actions,
        );
      },
    );
  }
}
