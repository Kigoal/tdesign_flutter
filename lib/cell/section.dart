import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:tdesign_icons_flutter/tdesign_icons_flutter.dart';

import '../theme/export.dart';
import '../divider/export.dart';
import './list.dart';
import './cell.dart';
import './interface.dart';

class TdSection extends StatelessWidget {
  const TdSection({
    super.key,
    this.header,
    this.footer,
    required this.children,
  });

  /// 单元格组标题
  final Widget? header;

  /// 单元格组底部
  final Widget? footer;

  /// 单元格组项目
  final List<Widget> children;

  double _getChildSize(
    BuildContext context, {
    required Widget? child,
  }) {
    if (child != null) {
      if (child is Icon) {
        return child.size ?? IconTheme.of(context).size ?? 0.0;
      } else if (child is Image) {
        return child.width ?? 0.0;
      }
    }

    return 0.0;
  }

  double _getDividerIndent(
    BuildContext context, {
    required Widget child,
  }) {
    if (child is TdCell) {
      return _getChildSize(context, child: child.leading);
    } else if (child is TdCellNavigation) {
      return _getChildSize(context, child: child.leading);
    }

    return 0.0;
  }

  List<Widget> _buildChildren(BuildContext context, TdThemeData theme) {
    List<Widget> list = [];

    for (var i = 0; i < children.length; i++) {
      final child = children[i];

      list.add(child);

      if (i != children.length - 1) {
        final indent = _getDividerIndent(context, child: child);

        list.add(TdDivider(
          indent: (indent == 0.0 ? indent : indent + theme.spacer2) + theme.spacer2,
        ));
      }
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    final theme = TdTheme.of(context);
    final listTheme = TdListInheritedWidget.of(context);

    final childrenWidget = IconTheme(
      data: IconThemeData(
        size: theme.spacer3,
        color: theme.brandColor,
      ).merge(listTheme?.iconTheme),
      child: DefaultTextStyle(
        style: theme.fontM.copyWith(color: theme.textColorPrimary).merge(listTheme?.labelStyle),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _buildChildren(context, theme),
        ),
      ),
    );

    switch (listTheme?.type ?? TdCellGroupType.insetGrouped) {
      case TdCellGroupType.insetGrouped:
        return _TdCellGroupInsetGroupedStyle(
          header: header,
          footer: footer,
          child: childrenWidget,
        );
      case TdCellGroupType.sidebar:
        return _TdCellGroupSidebarStyle(
          header: header,
          footer: footer,
          child: childrenWidget,
        );
    }
  }
}

/// 卡片风格
class _TdCellGroupInsetGroupedStyle extends StatelessWidget {
  const _TdCellGroupInsetGroupedStyle({
    this.header,
    this.footer,
    required this.child,
  });

  final Widget? header;

  final Widget? footer;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = TdTheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (header != null)
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: theme.spacer / 2,
              horizontal: theme.spacer4,
            ),
            child: DefaultTextStyle(
              style: theme.fontBase.copyWith(
                color: theme.textColorSecondary,
              ),
              child: header!,
            ),
          ),
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: theme.spacer2,
          ),
          decoration: BoxDecoration(
            color: theme.backgroundColorContainer,
            borderRadius: theme.radiusLarge,
          ),
          clipBehavior: Clip.antiAlias,
          child: child,
        ),
        if (footer != null)
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: theme.spacer / 2,
              horizontal: theme.spacer4,
            ),
            child: DefaultTextStyle(
              style: theme.fontBase.copyWith(
                color: theme.textColorSecondary,
              ),
              child: footer!,
            ),
          ),
      ],
    );
  }
}

/// 导航栏风格
class _TdCellGroupSidebarStyle extends StatefulWidget {
  const _TdCellGroupSidebarStyle({
    this.header,
    this.footer,
    required this.child,
  });

  final Widget? header;

  final Widget? footer;

  final Widget child;

  @override
  State<_TdCellGroupSidebarStyle> createState() => _TdCellGroupSidebarStyleState();
}

class _TdCellGroupSidebarStyleState extends State<_TdCellGroupSidebarStyle> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  /// 是否折叠分组
  late bool _isCollapse = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: kThemeAnimationDuration,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  void _handleTap() {
    if (_isCollapse) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }

    _isCollapse = !_isCollapse;
  }

  @override
  Widget build(BuildContext context) {
    final theme = TdTheme.of(context);

    Widget? header;
    if (widget.header != null) {
      header = GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _handleTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: theme.spacer / 2,
            horizontal: theme.spacer2,
          ),
          child: Row(
            children: [
              DefaultTextStyle(
                style: theme.fontL.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.textColorPrimary,
                ),
                child: widget.header!,
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(right: theme.spacer2),
                child: AnimatedBuilder(
                  animation: _animationController,
                  child: IconTheme(
                    data: IconThemeData(
                      size: theme.spacer3,
                      color: theme.brandColor,
                    ),
                    child: const Icon(TdIcons.chevron_down),
                  ),
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: -math.pi / 2 * _animationController.value,
                      child: child,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }

    final children = Container(
      margin: EdgeInsets.symmetric(
        horizontal: theme.spacer2,
      ),
      decoration: BoxDecoration(
        color: theme.backgroundColorContainer,
        borderRadius: theme.radiusLarge,
      ),
      clipBehavior: Clip.antiAlias,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Align(
            heightFactor: 1.0 - _animationController.value,
            child: widget.child,
          );
        },
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (header != null) header,
        children,
      ],
    );
  }
}
