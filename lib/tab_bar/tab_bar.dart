import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tdesign_mobile_flutter/tdesign_mobile_flutter.dart';

import '../theme/export.dart';
import './tab_bar_controller.dart';
import './interface.dart';

/// 56.0
const kTdTabBarHeight = 56.0;

class TdTabBar extends StatefulWidget {
  const TdTabBar({
    super.key,
    required this.onChanged,
    this.initialIndex = 0,
    this.shape = TdTabBarShape.round,
    required this.items,
  });

  /// 点击事件
  final ValueChanged<int> onChanged;

  /// 当前选项
  final int initialIndex;

  /// 形状类型
  final TdTabBarShape shape;

  /// 子元素
  final List<TdTabBarItem> items;

  @override
  State<TdTabBar> createState() => _TdTabBarState();
}

class _TdTabBarState extends State<TdTabBar> {
  late final TdTabBarController _controller;

  @override
  void initState() {
    super.initState();

    _controller = TdTabBarController(
      initialIndex: widget.initialIndex,
      initialMap: TdTabBarController.makeSelectedMap(
        widget.items.length,
        widget.initialIndex,
      ),
    );
  }

  @override
  void didUpdateWidget(covariant TdTabBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.items.length != oldWidget.items.length) {
      _controller.selectedMap = TdTabBarController.makeSelectedMap(
        widget.items.length,
        _controller.index,
      );
    }
  }

  void _handleChanged(int index) {
    _controller.index = index;

    widget.onChanged(index);
  }

  List<Widget> _buildItems() {
    final List<Widget> list = [];

    for (var i = 0; i < widget.items.length; i++) {
      final item = widget.items[i];

      list.add(
        Expanded(
          child: _TdTabBarButton(
            onPressed: () {
              _handleChanged(i);
            },
            index: i,
            shape: widget.shape,
            icon: item.icon,
            activeIcon: item.activeIcon,
            label: item.label,
          ),
        ),
      );
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    final theme = TdTheme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.backgroundColorContainer,
        border: Border(
          top: BorderSide(
            color: theme.componentStroke,
            width: 0.5,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: kTdTabBarHeight,
          child: ChangeNotifierProvider(
            create: (context) => _controller,
            child: Row(
              children: _buildItems(),
            ),
          ),
        ),
      ),
    );
  }
}

class _TdTabBarButton extends StatelessWidget {
  const _TdTabBarButton({
    required this.onPressed,
    required this.index,
    this.shape = TdTabBarShape.round,
    this.icon,
    this.activeIcon,
    this.label,
  });

  /// 点击事件
  final GestureTapCallback onPressed;

  final int index;

  /// 形状类型
  final TdTabBarShape shape;

  /// 图标
  final Icon? icon;

  /// 选中时的图标
  final Icon? activeIcon;

  /// 标签
  final String? label;

  Widget _buildChild(TdThemeData theme, bool isActive) {
    final currentIcon = isActive ? (activeIcon ?? icon) : icon;

    final foregroundColor = isActive ? theme.brandColor : theme.textColorPrimary;

    Widget? labelWidget;
    if (label != null) {
      final textStyle = icon != null ? theme.fontS : theme.fontM;
      final fontWeight = isActive ? FontWeight.w600 : FontWeight.normal;

      labelWidget = Text(
        label!,
        style: textStyle.copyWith(
          height: 1.33,
          color: foregroundColor,
          fontWeight: fontWeight,
        ),
      );
    }

    Widget? iconWidget;
    if (currentIcon != null) {
      final size = label != null ? (theme.spacer3 - theme.spacer / 2) : theme.spacer3;

      iconWidget = IconTheme(
        data: IconThemeData(
          color: foregroundColor,
          size: size,
        ),
        child: currentIcon,
      );
    }
    return Container(
      decoration: BoxDecoration(
        color: isActive && shape == TdTabBarShape.round ? theme.brandColorLight : null,
        borderRadius: theme.radiusRound,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (iconWidget != null) iconWidget,
          if (labelWidget != null) labelWidget,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = TdTheme.of(context);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: theme.spacer,
          horizontal: theme.spacer1,
        ),
        child: Selector<TdTabBarController, bool>(
          selector: (context, model) => model.selectedMap[index],
          builder: (context, value, child) {
            return _buildChild(theme, value);
          },
        ),
      ),
    );
  }
}

class TdTabBarItem {
  const TdTabBarItem({
    required this.icon,
    this.activeIcon,
    required this.label,
  });

  const TdTabBarItem.icon({
    this.icon,
    this.activeIcon,
  }) : label = null;

  const TdTabBarItem.text({
    this.label,
  })  : icon = null,
        activeIcon = null;

  /// 默认图标
  final Icon? icon;

  /// 选中图标
  final Icon? activeIcon;

  /// 标签
  final String? label;
}
