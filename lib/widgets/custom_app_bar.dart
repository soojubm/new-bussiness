import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final IconData? icon;
  final bool isIconRight;
  final List<Widget>? actions;
  final bool automaticallyImplyLeading;

  CustomAppBar({
    required this.title,
    this.icon,
    this.isIconRight = false,
    this.actions,
    this.automaticallyImplyLeading = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: isIconRight
          ? Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(icon),
                SizedBox(width: 10),
                Text(title),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(icon),
                SizedBox(width: 10),
                Text(title),
              ],
            ),
      // leading: isIconRight ? null : Icon(icon),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
