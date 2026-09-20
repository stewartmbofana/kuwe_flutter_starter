import 'dart:io';

import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  final progress = context.logger.progress('Installing packages');

  // Run `flutter pub get` after generation.
  final result = await Process.run(
    'flutter',
    ['pub', 'get'],
    runInShell: true,
  );

  if (result.exitCode != 0) {
    progress.fail('Failed to install packages.');
    context.logger.err(result.stderr.toString());
    return;
  }

  progress.complete('Packages installed successfully.');
}
