import 'package:flutter/material.dart';

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

void showTdPopup<T>({
  Key? key,
  required BuildContext context,
  Color? backgroundColor,
  bool barrierDismissible = true,
  bool enableDrag = true,
  bool useSafeArea = true,
  bool useRootNavigator = true,
  RouteSettings? settings,
  AnimationController? transitionAnimationController,
  required WidgetBuilder builder,
}) {
  final mediaQuery = MediaQuery.of(context);

  final theme = TdTheme.of(context);

  showModalBottomSheet(
    context: context,
    constraints: BoxConstraints(
      maxWidth: 640.0,
      maxHeight: mediaQuery.size.height - mediaQuery.padding.top - (mediaQuery.size.width >= 640.0 ? 56.0 : 64.0),
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

void popTdPopup<T extends Object?>(
  BuildContext context, {
  bool useRootNavigator = true,
  T? result,
}) {
  final navigator = Navigator.of(context, rootNavigator: useRootNavigator);

  if (navigator.canPop()) {
    navigator.pop<T>(result);
  }
}
