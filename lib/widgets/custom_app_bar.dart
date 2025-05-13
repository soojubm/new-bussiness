import 'package:flutter/material.dart';

enum AppBarVariant { menu, up }

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final AppBarVariant variant;
  final VoidCallback? onMenuPressed;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.variant = AppBarVariant.up, // ✅ 기본값 설정
    this.onMenuPressed,
    this.onBackPressed,
    this.actions,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final isMenu = variant == AppBarVariant.menu;

    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: isMenu,
      leading: isMenu
          ? IconButton(
              icon: const Icon(Icons.menu),
              onPressed: onMenuPressed ?? () {},
            )
          : IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed:
                  onBackPressed ?? () => Navigator.of(context).maybePop(),
            ),
      title: Align(
        alignment: isMenu ? Alignment.center : Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      actions: actions,
    );
  }
}
