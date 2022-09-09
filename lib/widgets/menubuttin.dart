import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  MenuButton(
      {Key? key,
      required this.iconButton,
      required this.textButton,
      required this.callback})
      : super(key: key);

  IconData? iconButton;
  String? textButton;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [
              Colors.blue,
              Colors.blueAccent,
              //add more colors
            ]),
            borderRadius: BorderRadius.circular(10),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                  blurRadius: 5) //blur radius of shadow
            ]),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              disabledForegroundColor: Colors.transparent.withOpacity(0.38),
              disabledBackgroundColor: Colors.transparent.withOpacity(0.12),
              shadowColor: Colors.transparent,
              //make color or elevated button transparent
            ),
            onPressed: callback,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  iconButton,
                  color: Colors.amber,
                  size: 70,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 18,
                    bottom: 18,
                  ),
                  child: Text(
                    textButton!,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            )));
  }
}
