import 'package:flutter/widgets.dart';

import 'dialog_action_button.dart';

class TdDialogNotification extends Notification {
  const TdDialogNotification({
    required this.item,
  });

  final TdDialogActionButton item;
}
