import 'dart:async';

import 'package:flutter/material.dart';

import '../global/export.dart';
import '../theme/export.dart';

class TdPopup extends StatelessWidget {
  const TdPopup({
    super.key,
    this.backgroundColor,
    this.useSafeArea = true,
    required this.child,
  });

  /// 背景颜色
  final Color? backgroundColor;

  /// 是否使用安全区
  final bool useSafeArea;

  /// 子元素
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = TdTheme.of(context);

    final Widget bottomSheet = useSafeArea
        ? SafeArea(
            left: false,
            top: false,
            right: false,
            child: child,
          )
        : child;

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.backgroundColorContainer,
        borderRadius: theme.radiusExtraL.copyWith(
          bottomLeft: Radius.zero,
          bottomRight: Radius.zero,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: bottomSheet,
    );
  }
}

class TdPopupPlugin {
  /// 弹出弹窗
  static Future<T?> open<T>({
    Key? key,
    Color? backgroundColor,
    bool barrierDismissible = true,
    bool enableDrag = true,
    bool useSafeArea = true,
    bool useRootNavigator = true,
    RouteSettings? settings,
    AnimationController? transitionAnimationController,
    required WidgetBuilder builder,
  }) {
    final context = TdConfig.instance.context;
    final theme = TdTheme.of(context);
    final mediaQuerySize = MediaQuery.sizeOf(context);
    final mediaQueryPadding = MediaQuery.paddingOf(context);

    return showModalBottomSheet(
      context: context,
      constraints: BoxConstraints(
        maxWidth: 640.0,
        maxHeight: mediaQuerySize.height - mediaQueryPadding.top - 12.0,
      ),
      elevation: 0.0,
      barrierColor: theme.maskActive.withOpacity(0.4),
      isScrollControlled: true,
      enableDrag: enableDrag,
      useSafeArea: useSafeArea,
      transitionAnimationController: transitionAnimationController,
      builder: (context) {
        return TdPopup(
          key: key,
          backgroundColor: backgroundColor,
          useSafeArea: useSafeArea,
          child: builder(context),
        );
      },
    );
  }

  /// 关闭弹窗
  static void pop<T>([T? result, bool useRootNavigator = true]) {
    final context = TdConfig.instance.context;
    final navigator = Navigator.of(context, rootNavigator: useRootNavigator);

    if (navigator.canPop()) {
      navigator.pop<T>(result);
    }
  }
}
