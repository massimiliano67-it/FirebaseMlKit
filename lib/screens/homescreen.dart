import 'package:firebasemlkit/screens/visionposition.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../classes/visionposition/visionpositionprovider.dart';
import '../widgets/menubutton.dart';
import '../widgets/navdrawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VisioPositionProvider visionProvider =
        context.watch<VisioPositionProvider>();

    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        //automaticallyImplyLeading: false,
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
                  iconButton: Icons.all_inclusive_sharp,
                  textButton: "Vision Positioning",
                  callback: () {
                    context.read<VisioPositionProvider>().setImage(value: null);
                    context
                        .read<VisioPositionProvider>()
                        .clearTextCustomPanelControl();
                    Get.to(const VisonPositionScreen());
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
