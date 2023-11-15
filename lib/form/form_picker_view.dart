import 'package:flutter/widgets.dart';
import 'package:tdesign_icons_flutter/tdesign_icons_flutter.dart';

import '../theme/export.dart';
import '../focus/export.dart';

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

    return TdFocus(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: theme.spacer1,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (content != null)
              Expanded(
                child: DefaultTextStyle(
                  style: theme.fontM.copyWith(
                    color: theme.textColorSecondary,
                  ),
                  textAlign: TextAlign.end,
                  child: content!,
                ),
              ),
            Icon(
              TdIcons.chevron_right,
              size: theme.spacer3,
              color: theme.textColorSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
