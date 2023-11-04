TDesign 适配移动端的组件库，适合在 flutter 技术栈项目中使用。

## Getting started

```bash
flutter pub add tdesign_flutter
```

## Usage

```dart
import 'package:tdesign_flutter/tdesign_flutter.dart';

void main() {
  runApp(AntApp(
    home: Scaffold(
      body: Center(
        child: TdButton(
          onPressed: () {
            //
          }
          child: const Text('按钮'),
        ),
      )
    ),
  ));
}
```
