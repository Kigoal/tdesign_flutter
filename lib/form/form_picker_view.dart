import 'package:flutter/widgets.dart';
import 'package:tdesign_icons_flutter/tdesign_icons_flutter.dart';

import '../theme/export.dart';

class TdFormPickerView extends StatelessWidget {
  const TdFormPickerView({
    super.key,
    this.content,
    this.onTap,
  });

  final Widget? content;

  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = TdTheme.of(context);

    Widget? contentWidget;
    if (content != null) {
      contentWidget = DefaultTextStyle(
        style: theme.fontM.copyWith(color: theme.textColorPlaceholder),
        textAlign: TextAlign.end,
        child: content!,
      );
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        final focus = FocusScope.of(context);

        // 点击时隐藏TextField的软键盘
        if (!focus.hasPrimaryFocus && focus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }

        onTap?.call();
      },
      child: Focus(
        canRequestFocus: true,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: theme.spacer1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (contentWidget != null)
                Expanded(
                  child: contentWidget,
                ),
              Icon(
                TdIcons.chevron_right,
                size: theme.spacer3,
                color: theme.textColorPlaceholder,
              ),
            ],
          ),
        ),
      ),
    );
  }
}