import 'dart:io';

import 'package:mason/mason.dart';

void run(HookContext context) {
  final logger = context.logger;
  final moduleFilePath = '${Directory.current.path}/lib/features';

  final module = Directory(moduleFilePath);

  final allModules =
      module.listSync().map((e) => e.path.split('/').last).toList();

  final moduleValue = context.vars['feature']?.toString();
  if (moduleValue == null ||
      moduleValue.isEmpty ||
      allModules.contains(moduleValue) == false) {
    context.vars['feature'] =
        logger.chooseOne('Select Feature: ', choices: allModules);
  }
}
