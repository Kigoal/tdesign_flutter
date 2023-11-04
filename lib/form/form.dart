import 'package:flutter/material.dart';

import '../cell/export.dart';

class TdForm extends StatelessWidget {
  const TdForm({
    super.key,
    this.formKey,
    this.autovalidateMode,
    required this.children,
  });

  final GlobalKey<FormState>? formKey;

  final AutovalidateMode? autovalidateMode;

  /// 单元格组项目
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: autovalidateMode,
      child: TdList(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: children,
      ),
    );
  }
}
