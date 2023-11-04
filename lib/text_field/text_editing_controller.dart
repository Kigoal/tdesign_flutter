import 'package:flutter/material.dart';

import '../theme/export.dart';

class TdTextEditingController extends TextEditingController {
  TdTextEditingController({
    super.text,
    this.editingTextStyle,
  });

  final TextStyle? editingTextStyle;

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    // If the composing range is out of range for the current text, ignore it to
    // preserve the tree integrity, otherwise in release mode a RangeError will
    // be thrown and this EditableText will be built with a broken subtree.
    final bool composingRegionOutOfRange =
        !value.isComposingRangeValid || !withComposing;

    if (composingRegionOutOfRange) {
      return TextSpan(style: style, text: text);
    }

    final theme = TdTheme.of(context);

    final defaultTextStyle = editingTextStyle ??
        TextStyle(
          backgroundColor: theme.componentBorder,
          // background: Paint()..colorFilter = ColorFilter.mode(),
        );

    final TextStyle composingStyle =
        style?.merge(defaultTextStyle) ?? defaultTextStyle;

    return TextSpan(
      style: style,
      children: <TextSpan>[
        TextSpan(text: value.composing.textBefore(value.text)),
        TextSpan(
          style: composingStyle,
          text: value.composing.textInside(value.text),
        ),
        TextSpan(text: value.composing.textAfter(value.text)),
      ],
    );
  }
}
