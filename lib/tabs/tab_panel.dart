import 'package:flutter/widgets.dart';

import '../theme/export.dart';

class TdTabPanel extends StatelessWidget {
  const TdTabPanel({
    super.key,
    this.isAction = false,
    required this.title,
  });

  /// 是否选中状态
  final bool isAction;

  /// 标题
  final Widget title;

  @override
  Widget build(BuildContext context) {
    final theme = TdTheme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: theme.spacer1,
        horizontal: theme.spacer2,
      ),
      child: title,
    );
  }
}
