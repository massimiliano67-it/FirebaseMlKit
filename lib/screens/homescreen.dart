import 'package:flutter/material.dart';

import '../widgets/menubuttin.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        title: const Text(
          "Firebase & MLKIT",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          padding: const EdgeInsets.fromLTRB(8, 19, 8, 0),
          child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16),
              children: [
                MenuButton(
                  iconButton: Icons.abc,
                  textButton: "Push me",
                  callback: () {
                    print("Button1");
                  },
                ),
                MenuButton(
                  iconButton: Icons.abc,
                  textButton: "Push me",
                  callback: () {
                    print("Button1");
                  },
                ),
                MenuButton(
                  iconButton: Icons.abc,
                  textButton: "Push me",
                  callback: () {
                    print("Button2");
                  },
                ),
                MenuButton(
                  iconButton: Icons.abc,
                  textButton: "Push me",
                  callback: () {
                    print("Button3");
                  },
                ),
              ])),
    );
  }
}
