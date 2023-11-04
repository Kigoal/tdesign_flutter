import 'package:flutter/material.dart';

import '../theme/export.dart';
import '../cell/export.dart';

typedef TdFormDynamicGroupItemBuilder = TdFormDynamicItem Function(
  BuildContext context,
  int index,
);

/// 表单分组容器
class TdFormDynamicGroup extends StatelessWidget {
  const TdFormDynamicGroup({
    super.key,
    required this.onAdd,
    required this.onDelete,
    required this.title,
    required this.itemCount,
    required this.itemBuilder,
  });

  /// 添加事件
  final VoidCallback onAdd;

  /// 删除事件
  final ValueChanged<int> onDelete;

  /// 分组标题
  final String title;

  /// 分组数量
  final int itemCount;

  /// 子元素
  final TdFormDynamicGroupItemBuilder itemBuilder;

  Widget _buildHeader(BuildContext context, int index) {
    final theme = TdTheme.of(context);

    if (itemCount > 1) {
      return Row(
        children: [
          Text('$title${index + 1}'),
          const Spacer(),
          GestureDetector(
            onTap: () {
              onDelete.call(index);
            },
            child: DefaultTextStyle.merge(
              style: TextStyle(color: theme.errorColor),
              child: const Text('删除'),
            ),
          ),
        ],
      );
    }

    return Text(title);
  }

  Widget _buildOpera() {
    return TdCellButton(
      onTap: onAdd,
      child: const Text('新 增'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = TdTheme.of(context);

    List<Widget> list = [];

    for (var i = 0; i < itemCount; i++) {
      if (i != 0) {
        list.add(SizedBox(height: theme.spacer2));
      }

      final item = itemBuilder(context, i);

      list.add(TdSection(
        key: item.key,
        header: _buildHeader(context, i),
        children: [
          ...item.children,
          if (i == (itemCount - 1)) _buildOpera(),
        ],
      ));
    }

    return Column(
      children: list,
    );
  }
}

class TdFormDynamicItem {
  const TdFormDynamicItem({
    required this.key,
    required this.children,
  });

  /// 唯一键
  /// 
  /// 如果没有设置会导致数据显示异常
  final Key key;

  /// 分组的子元素
  final List<Widget> children;
}
