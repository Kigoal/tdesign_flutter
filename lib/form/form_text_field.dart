import 'package:flutter/material.dart';

import '../text_field/export.dart';
import './form_item.dart';

class TdFormTextField extends FormField<String> {
  TdFormTextField({
    super.key,
    super.onSaved,
    super.validator,
    this.controller,
    String? initialValue,
    super.autovalidateMode,
    ValueChanged<String>? onChanged,
    int? maxLength,
    EdgeInsets? contentPadding,
    Widget? label,
    double? labelWidth,
    TextAlign? labelAlign,
    Widget? help,
    String? hintText,
  }) : super(
          initialValue: controller?.text ?? initialValue,
          builder: (field) {
            final state = field as _TdFormTextFieldState;

            void handleChanged(String value) {
              field.didChange(value);

              onChanged?.call(value);
            }

            Widget? errorTextWidget;
            if (field.errorText != null) {
              errorTextWidget = Text(field.errorText!);
            }

            final contentWidget = TdTextField(
              onChanged: handleChanged,
              controller: state._effectiveController,
              hintText: hintText,
              contentPadding: contentPadding,
              // textInputAction: TextInputAction.next,
              maxLength: maxLength,
            );

            return TdFormItem(
              label: label,
              labelWidth: labelWidth,
              labelAlign: labelAlign,
              help: help,
              errorMessage: errorTextWidget,
              child: contentWidget,
            );
          },
        );

  TdFormTextField.multiple({
    super.key,
    super.onSaved,
    super.validator,
    this.controller,
    String? initialValue,
    super.autovalidateMode,
    ValueChanged<String>? onChanged,
    int? maxLength,
    int minLines = kTdTextFieldMultipleMinLine,
    int maxLines = kTdTextFieldMultipleMaxLine,
    EdgeInsets? contentPadding,
    Widget? label,
    double? labelWidth,
    TextAlign? labelAlign,
    Widget? help,
    String? hintText,
  }) : super(
          initialValue: controller?.text ?? initialValue,
          builder: (field) {
            final state = field as _TdFormTextFieldState;

            void handleChanged(String value) {
              field.didChange(value);

              onChanged?.call(value);
            }

            Widget? errorTextWidget;
            if (field.errorText != null) {
              errorTextWidget = Text(field.errorText!);
            }

            final contentWidget = TdTextField.multiple(
              onChanged: handleChanged,
              controller: state._effectiveController,
              hintText: hintText,
              contentPadding: contentPadding,
              maxLength: maxLength,
              minLines: minLines,
              maxLines: maxLines,
            );

            return TdFormItem(
              direction: Axis.vertical,
              label: label,
              labelWidth: labelWidth,
              labelAlign: labelAlign,
              help: help,
              errorMessage: errorTextWidget,
              child: contentWidget,
            );
          },
        );

  /// controller 用户获取或者赋值输入内容
  final TextEditingController? controller;

  @override
  FormFieldState<String> createState() => _TdFormTextFieldState();
}

class _TdFormTextFieldState extends FormFieldState<String> {
  TextEditingController? _controller;

  TextEditingController? get _effectiveController => _formField.controller ?? _controller;

  TdFormTextField get _formField => super.widget as TdFormTextField;

  @override
  void initState() {
    super.initState();

    if (_formField.controller == null) {
      _controller = TdTextEditingController(text: widget.initialValue);
    } else {
      _formField.controller!.addListener(_handleControllerChanged);
    }
  }

  @override
  void didUpdateWidget(TdFormTextField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (_formField.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      _formField.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && _formField.controller == null) {
        _controller = TextEditingController.fromValue(oldWidget.controller!.value);
      }

      if (_formField.controller != null) {
        setValue(_formField.controller!.text);

        if (oldWidget.controller == null) {
          _controller = null;
        }
      }
    }
  }

  @override
  void dispose() {
    _formField.controller?.removeListener(_handleControllerChanged);

    _controller?.dispose();

    super.dispose();
  }

  @override
  void didChange(String? value) {
    super.didChange(value);

    if (value != null && _effectiveController!.text != value) {
      _effectiveController!.text = value;
    }
  }

  @override
  void reset() {
    super.reset();

    if (widget.initialValue != null) {
      setState(() {
        _effectiveController!.text = widget.initialValue!;
      });
    }
  }

  void _handleControllerChanged() {
    if (_effectiveController!.text != value) {
      didChange(_effectiveController!.text);
    }
  }
}
