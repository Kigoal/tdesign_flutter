import 'package:flutter/widgets.dart';
import 'package:tdesign_icons_flutter/tdesign_icons_flutter.dart';

import '../theme/export.dart';
import './interface.dart';

enum _TdPopupAppbarStyle {
  confirmAndCancel,
  close,
}

class TdPopupAppbar extends StatelessWidget implements PreferredSizeWidget {
  const TdPopupAppbar({
    super.key,
    this.title,
    Widget? cancel,
    GestureTapCallback? onCancel,
    Widget? confirm,
    GestureTapCallback? onConfirm,
  })  : _style = _TdPopupAppbarStyle.confirmAndCancel,
        leading = cancel,
        onLeadingClick = onCancel,
        trailing = confirm,
        onTrailingClick = onConfirm;

  const TdPopupAppbar.close({
    super.key,
    this.title,
    GestureTapCallback? onClosing,
  })  : _style = _TdPopupAppbarStyle.close,
        leading = null,
        onLeadingClick = null,
        trailing = null,
        onTrailingClick = onClosing;

  /// 显示类型
  final _TdPopupAppbarStyle _style;

  /// 标题
  final Widget? title;

  /// 取消按钮
  final Widget? leading;

  /// 点击取消事件
  final GestureTapCallback? onLeadingClick;

  /// 确认按钮
  final Widget? trailing;

  /// 点击确认事件
  final GestureTapCallback? onTrailingClick;

  Widget _buildToolbarItem(
    TdThemeData theme,
    GestureTapCallback? onTap,
    Widget child,
  ) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(theme.spacer2),
        child: child,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kTdPopupAppbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = TdTheme.of(context);

    Widget? leadingWidget;
    Widget? trailingWidget;

    if (_style == _TdPopupAppbarStyle.confirmAndCancel) {
      if (leading != null) {
        leadingWidget = IconTheme(
          data: IconThemeData(
            size: theme.spacer3,
            color: theme.brandColor,
          ),
          child: DefaultTextStyle(
            style: theme.fontM.copyWith(
              color: theme.brandColor,
            ),
            child: _buildToolbarItem(theme, onLeadingClick, leading!),
          ),
        );
      }

      if (trailing != null) {
        trailingWidget = IconTheme(
          data: IconThemeData(
            size: theme.spacer3,
            color: theme.brandColor,
            weight: 600.0,
          ),
          child: DefaultTextStyle(
            style: theme.fontM.copyWith(
              color: theme.brandColor,
              fontWeight: FontWeight.w600,
            ),
            child: _buildToolbarItem(theme, onTrailingClick, trailing!),
          ),
        );
      }
    } else {
      trailingWidget = IconTheme(
        data: IconThemeData(
          size: theme.spacer3,
          color: theme.textColorPrimary,
        ),
        child: _buildToolbarItem(
          theme,
          onTrailingClick,
          const Icon(TdIcons.close),
        ),
      );
    }

    Widget? titleWidget;
    if (title != null) {
      titleWidget = DefaultTextStyle(
        style: kTdPopupAppbarTitleStyle.copyWith(
          color: theme.textColorPrimary,
          fontWeight: FontWeight.w700,
        ),
        child: title!,
      );
    }

    return SizedBox.fromSize(
      size: preferredSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (leadingWidget != null)
            Positioned(
              left: 0.0,
              child: leadingWidget,
            ),
          if (trailingWidget != null)
            Positioned(
              right: 0.0,
              child: trailingWidget,
            ),
          Center(
            child: titleWidget,
          ),
        ],
      ),
    );
  }
}
