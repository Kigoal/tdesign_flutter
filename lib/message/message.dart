import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tdesign_icons_flutter/tdesign_icons_flutter.dart';

import '../global/export.dart';
import '../theme/export.dart';
import './interface.dart';

const _kTdMessageIconSize = 22.0;
const _kTdMeesageHeight = 48.0;
const _kTdMeesageOffset = 12.0;
const _kTdMessageDuration = Duration(seconds: 3);

typedef TdMessageClose = void Function();

class TdMessage extends StatefulWidget {
  const TdMessage({
    super.key,
    this.onClosing,
    this.type = TdMessageType.info,
    this.duration = _kTdMessageDuration,
    this.textAlign = TextAlign.start,
    this.icon,
    required this.content,
  });

  /// 结束时触发的事件
  final TdMessageClose? onClosing;

  /// 消息组件风格
  final TdMessageType type;

  /// 持续时长
  final Duration duration;

  /// 文本对齐方式
  final TextAlign textAlign;

  /// 消息提醒前面的图标
  final Icon? icon;

  /// 用于自定义消息弹出内容
  final Text content;

  @override
  State<TdMessage> createState() => _TdMessageState();
}

class _TdMessageState extends State<TdMessage> with SingleTickerProviderStateMixin {
  /// 进入/退出动画
  late final AnimationController _animationController;
  late final CurvedAnimation _curvedAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: kThemeAnimationDuration,
    );
    _curvedAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.ease,
    );

    // 开始进入动画1
    _animationController.forward();

    // 定时器
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
    _curvedAnimation.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.paddingOf(context);
    final theme = TdTheme.of(context);

    final offset = mediaQuery.top + _kTdMeesageOffset;

    return AnimatedBuilder(
      animation: _curvedAnimation,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: theme.spacer2,
        ),
        child: Align(
          alignment: Alignment.topCenter,
          child: TdRawMessage(
            type: widget.type,
            textAlign: widget.textAlign,
            icon: widget.icon,
            content: widget.content,
          ),
        ),
      ),
      builder: (context, child) {
        return Positioned(
          top: offset + _kTdMeesageHeight * (_animationController.value - 1.0),
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
    this.type = TdMessageType.info,
    this.textAlign = TextAlign.start,
    this.icon,
    required this.content,
  });

  /// 消息组件风格
  final TdMessageType type;

  /// 文本对齐方式
  final TextAlign textAlign;

  /// 消息提醒前面的图标
  final Icon? icon;

  /// 用于自定义消息弹出内容
  final Text content;

  Color _buildThemeColor(TdThemeData theme) {
    return switch (type) {
      TdMessageType.info => theme.brandColor,
      TdMessageType.success => theme.successColor,
      TdMessageType.warning => theme.warningColor,
      TdMessageType.error => theme.errorColor,
    };
  }

  Icon _buildThemeIcon(TdThemeData theme) {
    return switch (type) {
      TdMessageType.info || TdMessageType.warning => const Icon(TdIcons.info_circle_filled),
      TdMessageType.success => const Icon(TdIcons.check_circle_filled),
      TdMessageType.error => const Icon(TdIcons.error_circle_filled),
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = TdTheme.of(context);

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: theme.spacer1,
        horizontal: theme.spacer2,
      ),
      decoration: BoxDecoration(
        color: theme.backgroundColorContainer,
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
                size: _kTdMessageIconSize,
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
              child: content,
            ),
          ),
        ],
      ),
    );
  }
}

class TdMessagePlugin {
  static OverlayEntry? _show({
    required TdMessageType type,
    Duration? duration,
    TextAlign? textAlign,
    Icon? icon,
    required Text content,
  }) {
    final context = TdConfig.instance.context;

    OverlayEntry? overlayWidget;

    void handleClosing() {
      /// 删除元素
      overlayWidget?.remove();
    }

    overlayWidget = OverlayEntry(
      builder: (context) {
        return TdMessage(
          onClosing: handleClosing,
          type: type,
          duration: duration ?? _kTdMessageDuration,
          textAlign: textAlign ?? TextAlign.left,
          content: content,
          icon: icon,
        );
      },
    );

    /// 插入元素
    Overlay.of(context).insert(overlayWidget);

    return overlayWidget;
  }

  /// 信息
  static OverlayEntry? info({
    Duration? duration,
    TextAlign? textAlign,
    Icon? icon,
    required Text content,
  }) {
    return _show(
      type: TdMessageType.info,
      duration: duration,
      textAlign: textAlign,
      icon: icon,
      content: content,
    );
  }

  /// 警告
  static OverlayEntry? warning({
    Duration? duration,
    TextAlign? textAlign,
    Icon? icon,
    required Text content,
  }) {
    return _show(
      type: TdMessageType.warning,
      duration: duration,
      textAlign: textAlign,
      icon: icon,
      content: content,
    );
  }

  /// 错误
  static OverlayEntry? error({
    Duration? duration,
    TextAlign? textAlign,
    Icon? icon,
    required Text content,
  }) {
    return _show(
      type: TdMessageType.error,
      duration: duration,
      textAlign: textAlign,
      icon: icon,
      content: content,
    );
  }

  /// 成功
  static OverlayEntry? success({
    Duration? duration,
    TextAlign? textAlign,
    Icon? icon,
    required Text content,
  }) {
    return _show(
      type: TdMessageType.success,
      duration: duration,
      textAlign: textAlign,
      icon: icon,
      content: content,
    );
  }
}
