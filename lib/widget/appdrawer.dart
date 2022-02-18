import 'package:cnss_djibouti_app/screens/CommuniquesScreen.dart';
import 'package:cnss_djibouti_app/screens/dashboard.dart';
import 'package:cnss_djibouti_app/screens/login.dart';
import 'package:cnss_djibouti_app/widget/APropre.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          ListTile(title: Text("s")),
          SizedBox(
            child: Divider(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: const Text('Accueil'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Dashboard(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Accueil'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Dashboard(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Mon compte'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Dashboard(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Communiques'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => CommuniquesPage(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('A propos'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => aproposcren(),
                ),
              );
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: const Text('Déconnexion'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => login(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
