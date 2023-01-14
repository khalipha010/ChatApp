import 'package:flutter/material.dart';
class L10n{
  static final all = [
    const Locale('en'),
    const Locale('sw'),
  ];

  static String getFlag(String code){
    if (code == 'sw') {
      return '🇳🇬';
    } else {
      return '🇺🇸';
    }
  }
}