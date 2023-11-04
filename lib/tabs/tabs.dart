import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../theme/export.dart';
import './tab_controller.dart';
import './tab_panel.dart';
import './interface.dart';

/// 标签栏高度
const kTdTabHeight = 48.0;

class TdTabs extends StatefulWidget implements PreferredSizeWidget {
  const TdTabs({
    super.key,
    this.initialIndex = 0,
    this.controller,
    this.isScrollable = false,
    required this.tabs,
  });

  /// 初始索引
  final int initialIndex;

  /// 控制器
  final TdTabController? controller;

  /// 是否允许滚动
  final bool isScrollable;

  /// 子元素
  final List<TdTabPanel> tabs;

  @override
  Size get preferredSize => const Size.fromHeight(kTdTabHeight);

  @override
  State<TdTabs> createState() => _TdTabsState();
}

class _TdTabsState extends State<TdTabs> with SingleTickerProviderStateMixin {
  late List<GlobalKey> _tabKeys;

  _TdTabTrackPainter? _indicatorPainter;

  late final ScrollController _scrollController;
  TdTabController? _controller;

  int _currentIndex = 0;

  TdTabController? get _effectiveController => widget.controller ?? _controller;

  @override
  void initState() {
    super.initState();

    _tabKeys = List.generate(widget.tabs.length, (index) => GlobalKey());

    if (widget.controller == null) {
      _controller = TdTabController(
        initialIndex: widget.initialIndex,
        length: widget.tabs.length,
        vsync: this,
      );

      _controller!.addListener(_handleTabControllerTick);
    } else {
      widget.controller!.addListener(_handleTabControllerTick);
    }

    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _effectiveController?.removeListener(_handleTabControllerTick);

    _controller?.dispose();

    super.dispose();
  }

  @override
  void didUpdateWidget(TdTabs oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleTabControllerTick);
      widget.controller?.addListener(_handleTabControllerTick);

      if (oldWidget.controller != null && widget.controller == null) {
        _controller = TdTabController(
          initialIndex: oldWidget.controller!.index,
          length: widget.tabs.length,
          vsync: this,
        );
      }

      if (oldWidget.controller == null && widget.controller != null) {
        _controller?.dispose();
        _controller = null;
      }
    }

    if (widget.tabs.length > _tabKeys.length) {
      final int delta = widget.tabs.length - _tabKeys.length;
      _tabKeys.addAll(List<GlobalKey>.generate(delta, (int n) => GlobalKey()));
    } else if (widget.tabs.length < _tabKeys.length) {
      _tabKeys.removeRange(widget.tabs.length, _tabKeys.length);
    }
  }

  void _handleTabControllerTick() {
    if (_effectiveController!.index != _currentIndex) {
      _currentIndex = _effectiveController!.index;

      if (widget.isScrollable && widget.tabs.length > 2) {
        _scrollToCurrentIndex();
      }
    }

    setState(() {});
  }

  double _tabCenteredScrollOffset(int index) {
    final position = _scrollController.position;

    return clampDouble(
      _indicatorPainter!.centerOf(index) - position.viewportDimension / 2,
      position.minScrollExtent,
      position.maxScrollExtent,
    );
  }

  void _scrollToCurrentIndex() {
    final offset = _tabCenteredScrollOffset(_currentIndex);

    _scrollController.animateTo(
      offset,
      duration: kTabScrollDuration,
      curve: Curves.ease,
    );
  }

  Widget _buildTabPanel(TdThemeData theme, int index) {
    Widget result = KeyedSubtree(
      key: _tabKeys[index],
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          _effectiveController!.index = index;
        },
        child: Center(
          child: widget.tabs[index],
        ),
      ),
    );

    if (_effectiveController!.index == index) {
      result = DefaultTextStyle.merge(
        style: TextStyle(
          color: theme.brandColor,
          fontWeight: FontWeight.w600,
        ),
        child: result,
      );
    }

    return result;
  }

  Widget _buildDivider(TdThemeData theme) {
    return Container(
      constraints: const BoxConstraints.expand(
        width: double.infinity,
        height: 0.5,
      ),
      color: theme.componentBorder,
    );
  }

  void _saveTabOffsets(
    List<double> tabOffsets,
    TextDirection textDirection,
    double width,
  ) {
    _indicatorPainter?.saveTabOffsets(tabOffsets, textDirection);
  }

  @override
  Widget build(BuildContext context) {
    final theme = TdTheme.of(context);

    final List<Widget> list = [];

    for (var i = 0; i < widget.tabs.length; i++) {
      Widget panel = _buildTabPanel(theme, i);

      if (!widget.isScrollable) {
        panel = Expanded(
          child: panel,
        );
      }

      list.add(panel);
    }

    _indicatorPainter ??= _TdTabTrackPainter(
      controller: _effectiveController!,
      tabKeys: _tabKeys,
      dividerColor: theme.componentBorder,
      trackColor: theme.brandColor,
    );

    Widget result = CustomPaint(
      painter: _indicatorPainter,
      child: DefaultTextStyle(
        style: theme.fontM.copyWith(
          color: theme.textColorPrimary,
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        child: _TdTabsFlex(
          onPerformLayout: _saveTabOffsets,
          mainAxisSize: MainAxisSize.min,
          children: list,
        ),
      ),
    );

    if (widget.isScrollable) {
      result = SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: _scrollController,
        child: result,
      );
    }

    return SizedBox(
      height: kTabsHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          result,
          _buildDivider(theme),
        ],
      ),
    );
  }
}

class _TdTabTrackPainter extends CustomPainter {
  _TdTabTrackPainter({
    required this.controller,
    required this.tabKeys,
    required this.dividerColor,
    required this.trackColor,
  }) : super(repaint: controller.animation);

  final TdTabController controller;
  final List<GlobalKey> tabKeys;

  final Color dividerColor;
  final Color trackColor;

  List<double>? _currentTabOffsets;
  TextDirection? _currentTextDirection;

  void saveTabOffsets(List<double>? tabOffsets, TextDirection? textDirection) {
    _currentTabOffsets = tabOffsets;
    _currentTextDirection = textDirection;
  }

  double centerOf(int tabIndex) {
    return (_currentTabOffsets![tabIndex] + _currentTabOffsets![tabIndex + 1]) / 2.0;
  }

  Rect indicatorOffset(Size size, int tabIndex) {
    final offset = _currentTabOffsets![tabIndex];
    final width = tabKeys[tabIndex].currentContext!.size!.width;

    final start = offset + (width - 16.0) / 2.0;
    final top = size.height - 4.0;

    return Rect.fromLTWH(start, top, 16.0, 4.0);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final maxLength = _currentTabOffsets!.length - 2;

    final index = controller.index.toDouble();
    final value = controller.animation!.value;

    final bool ltr = index > value;

    final from = (ltr ? value.floor() : value.ceil()).clamp(0, maxLength);
    final to = (ltr ? from + 1 : from - 1).clamp(0, maxLength);

    final fromRect = indicatorOffset(size, from);
    final toRect = indicatorOffset(size, to);

    final Paint trackPaint = Paint()..color = trackColor;

    canvas.drawRect(
      Rect.lerp(fromRect, toRect, (value - from.toDouble()).abs())!,
      trackPaint,
    );
  }

  @override
  bool shouldRepaint(_TdTabTrackPainter oldDelegate) {
    return false;
  }
}

typedef _LayoutCallback = void Function(List<double> xOffsets, TextDirection textDirection, double width);

class _TdTabsRenderer extends RenderFlex {
  _TdTabsRenderer({
    required super.direction,
    required super.mainAxisSize,
    required super.mainAxisAlignment,
    required super.crossAxisAlignment,
    required super.textDirection,
    required super.verticalDirection,
    required this.onPerformLayout,
  });

  _LayoutCallback onPerformLayout;

  @override
  void performLayout() {
    super.performLayout();
    // xOffsets will contain childCount+1 values, giving the offsets of the
    // leading edge of the first tab as the first value, of the leading edge of
    // the each subsequent tab as each subsequent value, and of the trailing
    // edge of the last tab as the last value.
    RenderBox? child = firstChild;
    final List<double> xOffsets = <double>[];
    while (child != null) {
      final FlexParentData childParentData = child.parentData! as FlexParentData;
      xOffsets.add(childParentData.offset.dx);
      assert(child.parentData == childParentData);
      child = childParentData.nextSibling;
    }
    assert(textDirection != null);
    switch (textDirection!) {
      case TextDirection.rtl:
        xOffsets.insert(0, size.width);
      case TextDirection.ltr:
        xOffsets.add(size.width);
    }
    onPerformLayout(xOffsets, textDirection!, size.width);
  }
}

class _TdTabsFlex extends Flex {
  const _TdTabsFlex({
    super.children,
    required this.onPerformLayout,
    required super.mainAxisSize,
  }) : super(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          verticalDirection: VerticalDirection.down,
        );

  final _LayoutCallback onPerformLayout;

  @override
  RenderFlex createRenderObject(BuildContext context) {
    return _TdTabsRenderer(
      direction: direction,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: getEffectiveTextDirection(context)!,
      verticalDirection: verticalDirection,
      onPerformLayout: onPerformLayout,
    );
  }

  @override
  void updateRenderObject(BuildContext context, _TdTabsRenderer renderObject) {
    super.updateRenderObject(context, renderObject);

    renderObject.onPerformLayout = onPerformLayout;
  }
}
