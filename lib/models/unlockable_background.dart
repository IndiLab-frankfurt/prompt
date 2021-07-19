import 'package:flutter/material.dart';

class UnlockableBackground {
  final String path;
  final String name;
  final int requiredDays;
  final LinearGradient backgroundColor;

  UnlockableBackground(
      this.name, this.path, this.requiredDays, this.backgroundColor);
}
