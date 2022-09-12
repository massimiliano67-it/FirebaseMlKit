import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../classes/visionpositionprovider.dart';

class SlidingPanel extends StatefulWidget {
  XFile? image;
  String? textCustomPanelControl;
  final PanelController panelController;

  SlidingPanel({
    Key? key,
    required this.image,
    required this.textCustomPanelControl,
    required this.panelController,
  }) : super(key: key);

  @override
  State<SlidingPanel> createState() => _SlidingPanelState();
}

class _SlidingPanelState extends State<SlidingPanel> {
  @override
  Widget build(BuildContext context) {
    VisioPositionProvider visionProvider =
        context.watch<VisioPositionProvider>();

    return SlidingUpPanel(
      backdropEnabled: true,
      renderPanelSheet: false,
      controller: widget.panelController,
      panel: _floatingPanel(context),
      collapsed: _floatingCollapsed(),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: [
          if (widget.image != null)
            Expanded(
              child: Column(
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      if (widget.panelController.isPanelOpen) {
                        widget.panelController.close();
                      }
                      visionProvider.clearTextCustomPanelControl();
                      visionProvider.setImage(value: null);
                    },
                    label: const Text('Remove Image'),
                    icon: const Icon(Icons.close),
                  ),
                  Row(
                    children: [
                      Expanded(child: Image.file(File(widget.image!.path))),
                    ],
                  ),
                ],
              ),
            )
          else
            const SizedBox(),
        ],
      ),
    );
  }

  Widget _floatingCollapsed() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0)),
      ),
      margin: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0.0),
      child: const Center(
        child: Text(
          "Waiting for results",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _floatingPanel(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(24.0)),
          boxShadow: [
            BoxShadow(
              blurRadius: 20.0,
              color: Colors.grey,
            ),
          ]),
      margin: const EdgeInsets.all(24.0),
      child: Center(
        child: // Text("This is the SlidingUpPanel when open"),
            widget.textCustomPanelControl != null
                // ignore: prefer_const_constructors
                ? Container(
                    margin: const EdgeInsets.all(15.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Text(
                        "Results\n\n${context.read<VisioPositionProvider>().textCustomPanelControl!}",
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  )

                //Text(widget.textCustomPanelControl!)
                : const Text("Waiting for the results"),
      ),
    );
  }
}
