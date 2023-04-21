import 'package:flutter/material.dart';

class UnlockableBackground {
  final String path;
  final String name;
  final int cost;
  final LinearGradient backgroundColor;

  UnlockableBackground(this.name, this.path, this.cost, this.backgroundColor);
}
