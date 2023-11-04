import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter/scheduler.dart';
import 'package:tdesign_icons_flutter/tdesign_icons_flutter.dart';

import '../theme/export.dart';
import '../popup/export.dart';
import '../tabs/export.dart';
import './cascader_item.dart';
import './interface.dart';

class TdCascader<T> extends StatefulWidget {
  const TdCascader({
    super.key,
    this.title,
    this.initialValue,
    required this.onChanged,
    required this.children,
  });

  /// 标题
  final Widget? title;

  /// 初始值
  final T? initialValue;

  /// 值改变事件
  final ValueChanged<T> onChanged;

  /// 子元素
  final List<TdCascaderItem<T>> children;

  @override
  State<TdCascader<T>> createState() => _TdCascaderState<T>();
}

class _TdCascaderState<T> extends State<TdCascader<T>>
    with SingleTickerProviderStateMixin {
  late final TdTabController _tabController;

  late final List<TdTabPanel> _tabPanel;
  late final List<_TdCascaderPage<T>> _tabView;
  late final List<int?> _currentSelectedIndex;

  @override
  void initState() {
    super.initState();

    _tabController = TdTabController(
      initialIndex: 0,
      length: 0,
      vsync: this,
    );

    _initValue();
  }

  /// 通过值获取对应的数据信息
  void _initValue() {
    final List<TdTabPanel> tabPanel = [];
    final List<_TdCascaderPage<T>> tabView = [];
    final List<int?> currentSelectedIndex = [];

    if (widget.initialValue != null &&
        _queryStack(
          widget.children,
          widget.initialValue as T,
          tabPanel,
          tabView,
          currentSelectedIndex,
        )) {
      _tabPanel = tabPanel;
      _tabView = tabView;
      _currentSelectedIndex = currentSelectedIndex;

      _tabController.index = _tabView.length - 1;
    } else {
      _tabPanel = [];
      _tabView = [];
      _currentSelectedIndex = [];

      _addItem(widget.children);
    }
  }

  /// 递归判断是否存在值
  bool _queryStack(
    List<TdCascaderItem<T>> list,
    T value,
    List<TdTabPanel> defaultTabPanel,
    List<_TdCascaderPage<T>> defaultTabView,
    List<int?> defaultSelectedIndex,
  ) {
    for (var i = 0; i < list.length; i++) {
      final item = list[i];

      if (item.value == value) {
        defaultTabPanel.add(TdTabPanel(title: Text(item.label)));
        defaultTabView.add(_TdCascaderPage<T>(
          onItemTap: _selectItem,
          selectedIndex: i,
          children: list,
        ));
        defaultSelectedIndex.add(i);

        return true;
      } else if (item.children != null) {
        if (_queryStack(
          item.children!,
          value,
          defaultTabPanel,
          defaultTabView,
          defaultSelectedIndex,
        )) {
          defaultTabPanel.insert(0, TdTabPanel(title: Text(item.label)));
          defaultTabView.insert(
              0,
              _TdCascaderPage<T>(
                onItemTap: _selectItem,
                selectedIndex: i,
                children: list,
              ));
          defaultSelectedIndex.insert(0, i);

          return true;
        }
      }
    }

    return false;
  }

  /// 点击选项事件
  void _selectItem(int selectedIndex) {
    final tabIndex = _tabController.index;

    final item = _tabView[tabIndex].children[selectedIndex];

    // 如果当前的tabIndex是最后一项则追加一条tab
    if (tabIndex != _tabView.length - 1) {
      final start = tabIndex + 1;
      final end = _tabView.length;

      _deleteItemRange(start, end);
    }

    _updateItem(tabIndex, selectedIndex, item.label);

    // 判断是否拥有下一级
    if (item.children != null) {
      _addItem(item.children!);

      // 在下一帧中修改tab选中的索引
      SchedulerBinding.instance.addPostFrameCallback((duration) {
        _tabController.index += 1;
      });
    } else {
      SchedulerBinding.instance.addPostFrameCallback((duration) {
        // 触发改变事件
        widget.onChanged(item.value);
      });
    }

    setState(() {});
  }

  /// 删除后面的内容
  void _deleteItemRange(int start, int end) {
    _tabPanel.removeRange(start, end);
    _tabView.removeRange(start, end);
    _currentSelectedIndex.removeRange(start, end);
  }

  /// 修改当前的内容
  void _updateItem(int tabIndex, int selectedIndex, String title) {
    _tabPanel[tabIndex] = TdTabPanel(title: Text(title));
    _tabView[tabIndex] = _TdCascaderPage(
      onItemTap: _selectItem,
      selectedIndex: selectedIndex,
      children: _tabView[tabIndex].children,
    );
    _currentSelectedIndex[tabIndex] = tabIndex;
  }

  /// 添加新内容
  void _addItem(List<TdCascaderItem<T>> children) {
    _tabPanel.add(const TdTabPanel(title: Text('选择选项')));
    _tabView.add(_TdCascaderPage<T>(
      onItemTap: _selectItem,
      children: children,
    ));
    _currentSelectedIndex.add(null);
  }

  Widget _buildHeader() {
    return TdTabs(
      controller: _tabController,
      isScrollable: true,
      tabs: _tabPanel,
    );
  }

  Widget _buildContent(TdThemeData theme) {
    final List<Widget> list = [];

    for (var i = 0; i < _tabView.length; i++) {
      list.add(_tabView[i]);
    }

    return SizedBox(
      height: kCascaderItemHeight * kCascaderItemCount,
      child: DefaultTextStyle(
        style: theme.fontM.copyWith(
          color: theme.textColorPrimary,
        ),
        child: TdTabsView(
          controller: _tabController,
          children: list,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = TdTheme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        _buildContent(theme),
      ],
    );
  }
}

class _TdCascaderPage<T> extends StatelessWidget {
  const _TdCascaderPage({
    required this.onItemTap,
    this.selectedIndex,
    required this.children,
  });

  /// 子项点击事件
  final ValueChanged<int> onItemTap;

  /// 选中的索引
  final int? selectedIndex;

  /// 子元素
  final List<TdCascaderItem<T>> children;

  /// 在有选择索引时滚动条定位到索引
  double _getScrollOffset() {
    if (selectedIndex != null) {
      final max = (children.length - kCascaderItemCount) * kCascaderItemHeight;
      final offset = kCascaderItemHeight * selectedIndex!;

      return min(offset, max);
    }

    return 0.0;
  }

  @override
  Widget build(BuildContext context) {
    final theme = TdTheme.of(context);

    return ListView.builder(
      controller: ScrollController(
        initialScrollOffset: _getScrollOffset(),
      ),
      cacheExtent: kCascaderItemHeight * 2.0,
      itemExtent: kCascaderItemHeight,
      itemCount: children.length,
      itemBuilder: (context, index) {
        final item = children[index];

        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            onItemTap(index);
          },
          child: Container(
            alignment: Alignment.centerLeft,
            height: kCascaderItemHeight,
            padding: EdgeInsets.symmetric(
              horizontal: theme.spacer2,
            ),
            child: Row(
              children: [
                Expanded(
                  child: item.child ?? Text(item.label),
                ),
                if (selectedIndex == index)
                  Padding(
                    padding: EdgeInsets.only(left: theme.spacer2),
                    child: Icon(
                      TdIcons.check,
                      size: theme.spacer3,
                      color: theme.brandColor,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

void showTdCascader<T>({
  required BuildContext context,
  T? initialValue,
  ValueChanged<T?>? onChanged,
  Widget? title,
  required List<TdCascaderItem<T>> children,
}) {
  showTdPopup(
    context: context,
    builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TdPopupAppbar.close(
            title: title,
            onClosing: () {
              popTdPopup(context);
            },
          ),
          TdCascader<T>(
            title: title,
            initialValue: initialValue,
            onChanged: (value) {
              onChanged?.call(value);

              popTdPopup(context);
            },
            children: children,
          ),
        ],
      );
    },
  );
}
