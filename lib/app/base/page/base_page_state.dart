import 'package:flutter/material.dart';

import '../../../core/utils/log/log_utils.dart';
import '../../../di/di.dart';
import '../navigation/app_navigator.dart';

abstract class BasePageState<T extends StatefulWidget>
    extends BasePageStateDelegate<T> with LogMixin {}

abstract class BasePageStateDelegate<T extends StatefulWidget>
    extends State<T> {
  final appRoute = getIt.get<IAppNavigator>();
}
