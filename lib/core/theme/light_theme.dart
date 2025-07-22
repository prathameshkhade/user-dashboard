import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: CupertinoColors.systemBlue,
      brightness: Brightness.light,
    ),
);