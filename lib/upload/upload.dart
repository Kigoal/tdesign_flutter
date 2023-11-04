import 'package:flutter/widgets.dart';

import './upload_controller.dart';
import './interface.dart';

typedef TdUploadChangedCallback = bool Function(List<TdUploadData> list);
typedef TdUploadRemoveCallback = bool Function(TdUploadData data, int index);
typedef TdUploadPreviewCallback = bool Function(TdUploadData data, int index);

abstract class TdUpload extends StatefulWidget {
  const TdUpload({
    super.key,
    this.onChanged,
    this.onRemove,
    this.onPreview,
    this.initialValue,
    this.controller,
    required this.action,
    this.maxCount = 0,
  });

  /// 改变事件
  final TdUploadChangedCallback? onChanged;

  /// 移除文件事件
  final TdUploadRemoveCallback? onRemove;

  /// 预览附件事件
  final TdUploadPreviewCallback? onPreview;

  /// 默认值
  final List<TdUploadData>? initialValue;

  /// 控制器
  final TdUploadController? controller;

  /// 上传地址
  final Uri action;

  /// 最大允许上传文件数量
  final int maxCount;
}


