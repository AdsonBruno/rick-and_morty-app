import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSize {
  final List<Widget>? actions;

  const CustomAppBar({super.key, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Image.asset('assets/images/rickandmortylogo.png', height: 45),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget get child => throw UnimplementedError();
}
