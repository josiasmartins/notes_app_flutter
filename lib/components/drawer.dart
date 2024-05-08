import "package:flutter/material.dart";
import "package:notes_app/components/drawer_tile.dart";
import "package:notes_app/pages/settings_page.dart";

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          // header
          const DrawerHeader(
            child: Icon(Icons.note),
          ),

          // notes tile
          DrawerTile(
            tile: "Notes",
            leading: Icon(Icons.home),
            onTap: () => Navigator.pop(context),
          ),

          DrawerTile(
            tile: "Settings",
            leading: Icon(Icons.settings),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
          )

          // settings
        ],
      ),
    );
  }
}
