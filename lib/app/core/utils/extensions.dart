import 'package:flutter/material.dart';
import 'package:get/get.dart';

extension PercentSize on double {
  double get hp => Get.height * (this / 100);
  double get wp => Get.width * (this / 100);

  // toRadixString(int i) {}
}

extension ResponsiveText on double {
  double get sp => Get.width / 100 * (this / 3);
}

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  String toHex({bool leadingHashSign = true}) {
    final alphaInt = (a * 255).toInt();
    final redInt = (r * 255).toInt();
    final greenInt = (g * 255).toInt();
    final blueInt = (b * 255).toInt();

    return '${leadingHashSign ? '#' : ''}'
        '${alphaInt.toRadixString(16).padLeft(2, '0').toUpperCase()}'
        '${redInt.toRadixString(16).padLeft(2, '0').toUpperCase()}'
        '${greenInt.toRadixString(16).padLeft(2, '0').toUpperCase()}'
        '${blueInt.toRadixString(16).padLeft(2, '0').toUpperCase()}';
  }
}
