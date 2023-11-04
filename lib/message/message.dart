import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tdesign_icons_flutter/tdesign_icons_flutter.dart';

import '../theme/export.dart';
import './interface.dart';

const kTdMessageIconSize = 22.0;
const kTdMeesageHeight = 48.0;
const kTdMeesageSpacer = 8.0;

const kTdMessageDefaultDuration = Duration(seconds: 3);

typedef TdMessageClose = void Function();

class TdMessage extends StatefulWidget {
  const TdMessage({
    super.key,
    this.type = TdMessageType.info,
    required this.title,
    this.icon,
    this.textAlign = TextAlign.start,
    this.duration = const Duration(seconds: 3),
    this.onClosing,
  });

  /// 消息组件风格
  final TdMessageType type;

  /// 用于自定义消息弹出内容
  final Text title;

  /// 消息提醒前面的图标
  final Icon? icon;

  /// 文本对齐方式
  final TextAlign textAlign;

  /// 持续时长
  final Duration duration;

  /// 结束时触发的事件
  final TdMessageClose? onClosing;

  @override
  State<TdMessage> createState() => _TdMessageState();
}

class _TdMessageState extends State<TdMessage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: kThemeAnimationDuration,
    );

    /// 开始进入动画
    _animationController.forward();

    /// 定时器
    Timer(widget.duration, () async {
      /// 开始退出动画
      await _animationController.reverse();

      /// 触发事件
      widget.onClosing?.call();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final theme = TdTheme.of(context);

    final offset = mediaQuery.padding.top + kTdMeesageHeight;

    return AnimatedBuilder(
      animation: _animationController,
      child: Align(
        alignment: Alignment.topCenter,
        child: SafeArea(
          minimum: EdgeInsets.all(theme.spacer2),
          child: TdRawMessage(
            type: widget.type,
            title: widget.title,
            icon: widget.icon,
            textAlign: widget.textAlign,
          ),
        ),
      ),
      builder: (context, child) {
        return Positioned(
          top: offset * (_animationController.value - 1.0),
          left: 0.0,
          right: 0.0,
          child: child!,
        );
      },
    );
  }
}

class TdRawMessage extends StatelessWidget {
  const TdRawMessage({
    super.key,
    required this.type,
    required this.title,
    this.icon,
    required this.textAlign,
  });

  /// 消息组件风格
  final TdMessageType type;

  /// 用于自定义消息弹出内容
  final Text title;

  /// 消息提醒前面的图标
  final Icon? icon;

  /// 文本对齐方式
  final TextAlign textAlign;

  Color _buildThemeColor(TdThemeData theme) {
    return switch (type) {
      TdMessageType.info => theme.brandColor6,
      TdMessageType.success => theme.successColor6,
      TdMessageType.warning => theme.warningColor6,
      TdMessageType.error => theme.errorColor6,
    };
  }

  Icon _buildThemeIcon(TdThemeData theme) {
    return switch (type) {
      TdMessageType.info ||
      TdMessageType.warning =>
        const Icon(TdIcons.info_circle_filled),
      TdMessageType.success => const Icon(TdIcons.check_circle_filled),
      TdMessageType.error => const Icon(TdIcons.error_circle_filled),
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = TdTheme.of(context);

    return Container(
      height: kTdMeesageHeight,
      padding: EdgeInsets.symmetric(
        horizontal: theme.spacer2,
      ),
      decoration: BoxDecoration(
        color: theme.textColorAnti,
        borderRadius: theme.radiusDefault,
        boxShadow: theme.shadow4,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(
              right: theme.spacer,
            ),
            child: IconTheme(
              data: IconThemeData(
                size: kTdMessageIconSize,
                color: _buildThemeColor(theme),
              ),
              child: icon ?? _buildThemeIcon(theme),
            ),
          ),
          Flexible(
            child: DefaultTextStyle(
              style: theme.fontM.copyWith(
                color: theme.textColorPrimary,
              ),
              textAlign: textAlign,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              child: title,
            ),
          ),
        ],
      ),
    );
  }
}

void showTdMessage(
  BuildContext context, {
  TdMessageType type = TdMessageType.info,
  required Text title,
  Icon? icon,
  TextAlign textAlign = TextAlign.start,
  Duration duration = kTdMessageDefaultDuration,
}) {
  late final OverlayEntry overlayWidget;

  void handleClosing() {
    /// 删除元素
    overlayWidget.remove();
  }

  overlayWidget = OverlayEntry(
    builder: (context) {
      return TdMessage(
        onClosing: handleClosing,
        type: type,
        title: title,
        icon: icon,
        textAlign: textAlign,
      );
    },
  );

  /// 插入元素
  Overlay.of(context).insert(overlayWidget);
}

void showTdInfoMessage(
  BuildContext context, {
  required Text title,
  Icon? icon,
}) {
  showTdMessage(
    context,
    type: TdMessageType.info,
    title: title,
    icon: icon,
  );
}

void showTdSuccessMessage(
  BuildContext context, {
  required Text title,
  Icon? icon,
}) {
  showTdMessage(
    context,
    type: TdMessageType.success,
    title: title,
    icon: icon,
  );
}

void showTdWarningMessage(
  BuildContext context, {
  required Text title,
  Icon? icon,
}) {
  showTdMessage(
    context,
    type: TdMessageType.warning,
    title: title,
    icon: icon,
  );
}

void showTdErrorMessage(
  BuildContext context, {
  required Text title,
  Icon? icon,
}) {
  showTdMessage(
    context,
    type: TdMessageType.error,
    title: title,
    icon: icon,
  );
}
