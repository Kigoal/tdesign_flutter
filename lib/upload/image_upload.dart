import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tdesign_icons_flutter/tdesign_icons_flutter.dart';

import '../theme/export.dart';
import './upload.dart';
import './upload_controller.dart';
import './interface.dart';

/// 每行显示3条数据
const kTdImageUploadItemCount = 4;

class TdImageUpload extends TdUpload {
  const TdImageUpload({
    super.key,
    super.onChanged,
    super.onRemove,
    super.onPreview,
    super.initialValue,
    super.controller,
    required super.action,
    super.maxCount,
    this.rowCount = kTdImageUploadItemCount,
    this.spacing,
    this.runSpacing,
  });

  /// 每行数量
  final int rowCount;

  /// 横向间隔
  final double? spacing;

  /// 纵向间隔
  final double? runSpacing;

  @override
  State<TdImageUpload> createState() => _TdImageUploadState();
}

class _TdImageUploadState extends State<TdImageUpload> {
  TdUploadController? _controller;

  TdUploadController? get _effectiveController => widget.controller ?? _controller;

  @override
  void initState() {
    super.initState();

    if (widget.controller == null) {
      _controller = TdUploadController(value: widget.initialValue ?? []);
    }
  }

  @override
  void didUpdateWidget(TdImageUpload oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.controller != oldWidget.controller) {
      if (widget.controller != null && oldWidget.controller == null) {
        _controller?.dispose();
        _controller = null;
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();

    super.dispose();
  }

  /// 是否展示上传按钮
  bool get showUploadButton => widget.maxCount == 0 || widget.controller!.value.length < widget.maxCount;

  void _handleAdd(XFile file) async {
    _effectiveController!.add(TdUploadData.uploadImage(file));

    final responseData = await _uploadFile(file);

    widget.onChanged?.call(_effectiveController!.value);
  }

  void _handleRemove(int index) {
    _effectiveController!.remove(index);
  }

  /// 上传文件
  Future<bool> _uploadFile(XFile file) async {
    final request = MultipartRequest('POST', widget.action)
      ..files.add(MultipartFile.fromBytes(
        'files[]',
        await file.readAsBytes(),
        filename: file.name,
      ));

    final response = await request.send();

    if (response.statusCode == 200) {
      return true;
    }

    return false;
  }

  Widget _buildItem(TdUploadData data, int index) {
    return TdUploadImageItem(
      onRemove: () {
        _handleRemove(index);

        widget.onRemove?.call(data, index);
      },
      onPreview: () {
        widget.onPreview?.call(data, index);
      },
      data: data,
    );
  }

  Widget _buildUploadButton() {
    return TdUploadImagePlaceholder(
      onFile: _handleAdd,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final theme = TdTheme.of(context);

        final spacing = widget.spacing ?? theme.spacer1;
        final runSpacing = widget.runSpacing ?? theme.spacer1;

        final maxWidth = constraints.maxWidth;
        final itemWidth = ((maxWidth - (widget.rowCount - 1) * spacing) / widget.rowCount).truncateToDouble();

        return ListenableBuilder(
          listenable: _effectiveController!,
          builder: (context, child) {
            final list = _effectiveController!.value;

            final children = [
              for (var i = 0; i < list.length; i++) _buildItem(list[i], i),
              if (showUploadButton) _buildUploadButton(),
            ];

            return Wrap(
              spacing: spacing,
              runSpacing: runSpacing,
              children: [
                for (final item in children)
                  SizedBox(
                    width: itemWidth,
                    height: itemWidth,
                    child: item,
                  ),
              ],
            );
          },
        );
      },
    );
  }
}

class TdUploadImageItem extends StatelessWidget {
  const TdUploadImageItem({
    super.key,
    required this.onRemove,
    required this.onPreview,
    required this.data,
  });

  /// 删除事件
  final VoidCallback onRemove;

  /// 预览事件
  final VoidCallback onPreview;

  /// 文件数据
  final TdUploadData data;

  Widget _buildImage() {
    if (data.url != null) {
      return Image.network(data.url!);
    }

    if (data.rawFile != null) {
      return Image.file(File(data.rawFile!.path));
    }

    return const CircularProgressIndicator.adaptive();
  }

  @override
  Widget build(BuildContext context) {
    final theme = TdTheme.of(context);

    final contianer = GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onPreview,
      child: Hero(
        tag: data.id,
        child: SizedBox.expand(
          child: _buildImage(),
        ),
      ),
    );

    final action = GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onRemove,
      child: Container(
        padding: EdgeInsets.all(theme.spacer / 4),
        decoration: BoxDecoration(
          color: theme.textColorPlaceholder,
          borderRadius: theme.radiusDefault.copyWith(
            topLeft: Radius.zero,
            bottomRight: Radius.zero,
          ),
        ),
        child: IconTheme(
          data: IconThemeData(
            size: theme.spacer3,
            color: theme.fontWhite1,
          ),
          child: const Icon(TdIcons.close),
        ),
      ),
    );

    return Container(
      decoration: BoxDecoration(
        borderRadius: theme.radiusDefault,
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          contianer,
          Positioned(
            top: 0.0,
            right: 0.0,
            child: action,
          ),
        ],
      ),
    );
  }
}

class TdUploadImagePlaceholder extends StatefulWidget {
  const TdUploadImagePlaceholder({
    super.key,
    required this.onFile,
  });

  /// 选择文件的事件
  final ValueChanged<XFile> onFile;

  @override
  State<TdUploadImagePlaceholder> createState() => _TdUploadImagePlaceholderState();
}

class _TdUploadImagePlaceholderState extends State<TdUploadImagePlaceholder> {
  late final ImagePicker _picker;

  @override
  void initState() {
    super.initState();

    _picker = ImagePicker();
  }

  void _handlePicker() async {
    final file = await _picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      widget.onFile(file);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = TdTheme.of(context);

    return GestureDetector(
      onTap: _handlePicker,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: theme.backgroundColorComponent,
          borderRadius: theme.radiusDefault,
        ),
        child: Icon(
          TdIcons.add,
          size: theme.spacer4,
          color: theme.textColorSecondary,
        ),
      ),
    );
  }
}
