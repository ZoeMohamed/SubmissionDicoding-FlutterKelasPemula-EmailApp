import 'package:flutter/material.dart';
extension Neumorphism on Widget {
  Widget addNeumorphism(
      {double blurRadius = 15,
      double borderRadius = 15,
      Offset offset = const Offset(5, 5),
      Color topShadowColor = Colors.white60,
      Color bottomShadowColor = const Color(0xFF234395)}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            offset: -offset,
            blurRadius: blurRadius,
            color: topShadowColor,
          ),
          BoxShadow(
            offset: offset,
            blurRadius: blurRadius,
            color: bottomShadowColor,
          ),
        ],
      ),
      child: this,
    );
  }
}
