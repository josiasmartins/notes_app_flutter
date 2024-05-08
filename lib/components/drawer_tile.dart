import "package:flutter/material.dart";

class DrawerTile extends StatelessWidget {
  final String tile;
  final Widget leading;
  final void Function()? onTap;

  const DrawerTile({
    super.key,
    required this.tile,
    required this.leading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0),
      child: ListTile(
        title: Text(
          tile,
          style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
        ),
        onTap: onTap,
      ),
    );
  }
}
