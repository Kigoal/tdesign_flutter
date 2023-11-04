import 'package:flutter/widgets.dart';
import 'package:tdesign_icons_flutter/tdesign_icons_flutter.dart';

import '../theme/export.dart';
import './list.dart';

const Duration kFadeOutDuration = Duration(milliseconds: 120);
const Duration kFadeInDuration = Duration(milliseconds: 180);

/// 单元格容器
class TdCellView extends StatefulWidget {
  const TdCellView({
    super.key,
    this.padding,
    this.onTap,
    required this.child,
  });

  /// 边距
  final EdgeInsetsGeometry? padding;

  /// 点击事件
  final GestureTapCallback? onTap;

  /// 子元素
  final Widget child;

  @override
  State<TdCellView> createState() => _TdCellViewState();
}

class _TdCellViewState extends State<TdCellView>
    with SingleTickerProviderStateMixin {
  bool _tapped = false;

  Widget _buildView(BuildContext context) {
    final theme = TdTheme.of(context);

    Widget result = Container(
      padding: widget.padding ??
          EdgeInsets.symmetric(
            vertical: theme.spacer1,
            horizontal: theme.spacer2,
          ),
      color: _tapped
          ? theme.backgroundColorContainerActive
          : theme.backgroundColorContainer,
      child: widget.child,
    );

    if (widget.onTap != null) {
      result = GestureDetector(
        onTap: widget.onTap,
        onTapDown: (details) => setState(() => _tapped = true),
        onTapUp: (details) => setState(() => _tapped = false),
        onTapCancel: () => setState(() => _tapped = false),
        child: result,
      );
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return _buildView(context);
  }
}

class TdCell extends StatelessWidget {
  const TdCell({
    super.key,
    this.onTap,
    this.leading,
    this.badge,
    required this.child,
  });

  /// 点击事件
  final GestureTapCallback? onTap;

  /// 左侧图标
  final Widget? leading;

  /// 标记内容
  final Widget? badge;

  /// 子元素
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = TdTheme.of(context);
    final listTheme = TdList.of(context);

    return TdCellView(
      onTap: onTap,
      child: Row(
        children: [
          if (leading != null)
            Padding(
              padding: EdgeInsets.only(right: theme.spacer2),
              child: leading!,
            ),
          child,
          if (badge != null)
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: theme.spacer2),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: DefaultTextStyle(
                    style: theme.fontM
                        .copyWith(color: theme.textColorPlaceholder)
                        .merge(listTheme?.badgeStyle),
                    textAlign: TextAlign.end,
                    child: badge!,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class TdCellButton extends StatelessWidget {
  const TdCellButton({
    super.key,
    required this.onTap,
    required this.child,
  });

  /// 点击事件
  final GestureTapCallback onTap;

  /// 子元素
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = TdTheme.of(context);

    return TdCellView(
      onTap: onTap,
      child: SizedBox(
        width: double.infinity,
        child: Center(
          child: DefaultTextStyle.merge(
            style: TextStyle(
              color: theme.brandColor,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

class TdCellNavigation extends StatelessWidget {
  const TdCellNavigation({
    super.key,
    required this.onTap,
    this.leading,
    this.badge,
    required this.child,
  });

  /// 点击事件
  final GestureTapCallback onTap;

  /// 左侧图标
  final Widget? leading;

  /// 标记内容
  final Widget? badge;

  /// 子元素
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = TdTheme.of(context);

    return TdCell(
      onTap: onTap,
      leading: leading,
      badge: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (badge != null) badge!,
          IconTheme(
            data: IconThemeData(
              size: theme.spacer3,
              color: theme.textColorPlaceholder,
            ),
            child: const Icon(TdIcons.chevron_right),
          ),
        ],
      ),
      child: child,
    );
  }
}
