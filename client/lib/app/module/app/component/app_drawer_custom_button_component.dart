import 'package:flutter/material.dart';

class AppDrawerCustomButtonComponent extends StatelessWidget {
  final String title;
  final IconData leading;
  final IconData? trailing;
  final void Function() onTap;
  const AppDrawerCustomButtonComponent({
    required this.title,
    required this.leading,
    this.trailing,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        onTap: onTap,
        leading: Icon(leading),
        title: Text(title),
        trailing: trailing == null ? null : Icon(trailing),
      ),
    );
  }
}
