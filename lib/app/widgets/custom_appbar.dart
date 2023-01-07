import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Color? backgroundColor;
  final PreferredSizeWidget? bottom;
  final Widget? leading;
  final TextStyle? style;

  final List<Widget>? actions;

  const CustomAppbar({
    Key? key,
    // ignore: non_constant_identifier_names
    this.backgroundColor,
    this.style,
    this.bottom,
    this.title,
    this.leading,
    this.actions,
  }) : super(key: key);
  @override
  //88
  Size get preferredSize => const Size.fromHeight(88.0);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppBar(
        backgroundColor: backgroundColor,
        elevation: 4.0,
        title: Text(
          title!,
          style: style,
        ),
        bottom: bottom,
        leading: leading,
        actions: actions,
      ),
    );
  }
}
