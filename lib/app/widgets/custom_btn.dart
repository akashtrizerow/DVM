// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UIButton extends StatelessWidget {
  UIButton(
      {Key? key,
      this.onTap,
      this.style,
      this.color,
      this.height,
      this.width,
      this.decoration,
      this.labelText = ""})
      : super(key: key);

  VoidCallback? onTap;
  final String labelText;
  final TextStyle? style;
  final Color? color;
  final Decoration? decoration;

  double? width;
  double? height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        height: height,
        width: width,
        child: Center(
          child: Text(
            labelText,
            style: style,
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          color: color,
        ),
      ),
    );
  }
}
