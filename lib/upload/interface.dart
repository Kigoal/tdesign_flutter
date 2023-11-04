import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

enum TdUploadType {
  image,
  file,
}

enum TdUploadState {
  loading,
  reload,
  failed,
}

const uuid = Uuid();

class TdUploadData {
  TdUploadData({
    required this.id,
    required this.type,
    required this.name,
    this.url,
    this.state = TdUploadState.loading,
    this.percent = 0,
  });

  TdUploadData.create({
    this.type = TdUploadType.image,
    required this.name,
    required this.url,
  })  : id = uuid.v4(),
        state = TdUploadState.loading,
        percent = 0;

  TdUploadData.uploadImage(XFile file)
      : id = uuid.v4(),
        type = TdUploadType.image,
        name = file.name,
        state = TdUploadState.loading,
        percent = 0,
        rawFile = file;

  /// 唯一id
  String id;

  /// 文件类型
  TdUploadType type;

  /// 文件名称
  String name;

  /// 文件远程地址
  String? url;

  /// 文件上传状态
  TdUploadState state;

  /// 上传进度。[0-100]
  int percent;

  /// 原始文件对象
  XFile? rawFile;
}
