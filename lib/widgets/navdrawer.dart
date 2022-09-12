import 'package:firebasemlkit/screens/homescreen.dart';
import 'package:firebasemlkit/screens/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebasemlkit/utils/authfirebase.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 10.0,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
                color: Colors.blueAccent,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/cover.png'))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Text(
                  'Ml Kit',
                  style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 35,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          ListTile(
              leading: const Icon(Icons.input),
              title: const Text('Home Page'),
              onTap: () => {Get.to(const HomeScreen())}),
          ListTile(
            leading: const Icon(Icons.verified_user),
            title: const Text('Perfil'),
            onTap: () => {},
          ),
          ListTile(
            leading: const Icon(Icons.verified_user),
            title: const Text('Logout'),
            onTap: () => {
              FireAuth.LogoutFromApp(),
              Get.to(const LoginScreen()),
            },
          ),
        ],
      ),
    );
  }
}
