import 'dart:async';
import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:tdesign_flutter/popup/popup.dart';
import 'package:tdesign_icons_flutter/tdesign_icons_flutter.dart';

import '../global/export.dart';
import '../theme/export.dart';
import '../popup/export.dart';
import './dialog_actions.dart';
import './dialog_notification.dart';

const kTdDialogTitleFontStyle = TextStyle(
  fontSize: 18.0,
  height: 26.0 / 18.0,
  fontWeight: FontWeight.bold,
);

class TdDialog extends StatelessWidget {
  const TdDialog({
    super.key,
    this.onClosed,
    this.image,
    this.title,
    required this.content,
    this.showCloseButton = false,
    this.scrollable = false,
    required this.actionButton,
  });

  /// 关闭事件
  final VoidCallback? onClosed;

  /// 图片
  final Image? image;

  /// 标题
  final Widget? title;

  /// 内容
  final Widget content;

  /// 是否显示关闭按钮
  final bool showCloseButton;

  /// 是否开启滚动条
  final bool scrollable;

  /// 操作按钮
  final TdDialogActions actionButton;

  void _handleClosed() {
    onClosed?.call();
  }

  bool _handleNotification(TdDialogNotification notification) {
    _handleClosed();

    return true;
  }

  @override
  Widget build(BuildContext context) {
    final theme = TdTheme.of(context);

    Widget? titleWidget;
    if (title != null) {
      titleWidget = DefaultTextStyle(
        style: kTdDialogTitleFontStyle.copyWith(
          color: theme.textColorPrimary,
        ),
        textAlign: TextAlign.center,
        maxLines: 1,
        child: title!,
      );
    }

    Widget contentWidget = DefaultTextStyle(
      style: theme.fontM.copyWith(
        color: theme.textColorSecondary,
      ),
      child: content,
    );
    if (scrollable) {
      contentWidget = SingleChildScrollView(
        child: contentWidget,
      );
    }

    Widget? imageWidget;
    if (image != null) {
      imageWidget = SizedBox(
        height: 160.0,
        child: Image(
          image: image!.image,
          fit: BoxFit.fitWidth,
        ),
      );
    }

    Widget? closeButtonWidget;
    if (showCloseButton) {
      closeButtonWidget = GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _handleClosed,
        child: Padding(
          padding: EdgeInsets.only(
            top: theme.spacer,
            right: theme.spacer,
          ),
          child: Icon(
            TdIcons.close,
            size: theme.spacer3,
            color: theme.textColorPlaceholder,
          ),
        ),
      );
    }

    return Container(
      margin: EdgeInsets.all(theme.spacer2),
      decoration: BoxDecoration(
        color: theme.backgroundColorContainer,
        borderRadius: theme.radiusLarge,
        boxShadow: theme.shadow3,
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (imageWidget != null) imageWidget,
              Flexible(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: theme.spacer3,
                    top: theme.spacer4,
                    right: theme.spacer3,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (titleWidget != null)
                        Padding(
                          padding: EdgeInsets.only(bottom: theme.spacer),
                          child: titleWidget,
                        ),
                      Flexible(
                        child: contentWidget,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(theme.spacer3),
                child: NotificationListener<TdDialogNotification>(
                  onNotification: _handleNotification,
                  child: actionButton,
                ),
              ),
            ],
          ),
          if (closeButtonWidget != null)
            Positioned(
              top: 0.0,
              right: 0.0,
              child: closeButtonWidget,
            ),
        ],
      ),
    );
  }
}

class TdDialogRoute<T> extends RawDialogRoute<T> {
  TdDialogRoute({
    required WidgetBuilder builder,
    CapturedThemes? themes,
    required super.barrierColor,
    super.barrierDismissible,
    super.barrierLabel,
    bool useSafeArea = true,
    super.settings,
    super.anchorPoint,
    super.traversalEdgeBehavior,
  }) : super(
          pageBuilder: (BuildContext buildContext, Animation<double> animation, Animation<double> secondaryAnimation) {
            final Widget pageChild = Builder(builder: builder);

            Widget dialog = themes?.wrap(pageChild) ?? pageChild;

            if (useSafeArea) {
              dialog = SafeArea(child: dialog);
            }

            return dialog;
          },
          transitionDuration: const Duration(milliseconds: 200),
          transitionBuilder:
              (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
            return Opacity(
              opacity: animation.value,
              child: Transform.scale(
                scale: 0.6 + animation.value * 0.4,
                child: child,
              ),
            );
          },
        );
}

class TdDialogPlugin {
  /// 弹出对话框
  static Future<void> open({
    bool barrierDismissible = false,
    bool useSafeArea = true,
    bool useRootNavigator = true,
    bool scrollable = false,
    bool showCloseButton = false,
    Image? image,
    Widget? title,
    required Widget content,
    required TdDialogActions actionButton,
  }) {
    final completer = Completer<void>();

    final context = TdConfig.instance.context;
    final theme = TdTheme.of(context);

    Navigator.of(context, rootNavigator: useRootNavigator).push(TdDialogRoute(
      builder: (context) {
        final mediaQuery = MediaQuery.sizeOf(context);

        final maxWidth = mediaQuery.width - theme.spacer2 * 2;
        final maxHeight = mediaQuery.height - theme.spacer6 * 2;

        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: min(320.0, maxWidth),
              maxHeight: maxHeight,
            ),
            child: TdDialog(
              onClosed: () {
                TdPopupPlugin.pop();

                completer.complete();
              },
              scrollable: scrollable,
              showCloseButton: showCloseButton,
              image: image,
              title: title,
              content: content,
              actionButton: actionButton,
            ),
          ),
        );
      },
      barrierColor: theme.maskActive,
      barrierDismissible: barrierDismissible,
      useSafeArea: useSafeArea,
      traversalEdgeBehavior: TraversalEdgeBehavior.closedLoop,
    ));

    return completer.future;
  }
}
