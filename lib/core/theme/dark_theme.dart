import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: CupertinoColors.systemBlue,
      brightness: Brightness.dark,
    ),
);