import 'package:flutter/material.dart';

extension ToBool on Brightness {
  bool get toBool => this == Brightness.dark ? true : false;
}
