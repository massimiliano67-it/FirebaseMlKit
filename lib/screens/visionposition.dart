import 'dart:io';
import 'package:firebasemlkit/classes/appstate/appstateprovider.dart';
import 'package:firebasemlkit/classes/visionposition/geopositionprovider.dart';
import 'package:firebasemlkit/classes/visionposition/visionpositionprovider.dart';
import '../classes/user/userprovider.dart';
import '../utils/firebasestorage.dart';
import '../utils/firestorebase.dart';
import 'package:firebasemlkit/widgets/navdrawer.dart';
import 'package:firebasemlkit/widgets/slidinguppanel.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../classes/visionposition/visionresult.dart';

class VisonPositionScreen extends StatefulWidget {
  const VisonPositionScreen({Key? key}) : super(key: key);

  @override
  State<VisonPositionScreen> createState() => _VisonPositionScreenState();
}

class _VisonPositionScreenState extends State<VisonPositionScreen> {
  final ImagePicker _picker = ImagePicker();
  final TextRecognizer _textRecognizer = TextRecognizer();
  final PanelController panelController = PanelController();
  late ImageLabeler imageLabeler;
  FirestoreBase dbStore = FirestoreBase();

// For geoposition

  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;

  @override
  void initState() {
    super.initState();
    CheckGps();
  }

  // ignore: non_constant_identifier_names
  void CheckGps() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // debug
          print('Location permissions are denied');
        } else if (permission == LocationPermission.deniedForever) {
          // debug
          print("'Location permissions are permanently denied");
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }
    }
  }

  getLocation(BuildContext context) async {
    String localLat = "";
    String localLong = "";
    String? valuePanelControl;

    this.context.read<GeoPositionProvider>().setPosition(
        value: await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high));

// ignore: use_build_context_synchronously
    localLat = this.context.read<GeoPositionProvider>().lat.toString();
// ignore: use_build_context_synchronously
    localLong = this.context.read<GeoPositionProvider>().long.toString();

// ignore: use_build_context_synchronously
    valuePanelControl =
        // ignore: use_build_context_synchronously
        this.context.read<VisioPositionProvider>().textCustomPanelControl;

// ignore: use_build_context_synchronously
    if (valuePanelControl != null) {
      valuePanelControl =
          ("$valuePanelControl\nPosition: \nLat: $localLat- Long: $localLong\n\n");
    } else {
      valuePanelControl = "\nPosition: Lat: $localLat - Long: $localLong\n\n";
    }
    // ignore: use_build_context_synchronously
    this.context.read<AppStateProvider>().setIsBusy(value: false);
    // ignore: use_build_context_synchronously
    this.context.read<AppStateProvider>().setCanProcess(value: true);
    // ignore: use_build_context_synchronously
    this
        .context
        .read<VisioPositionProvider>()
        .setTextCustomPanelControl(value: valuePanelControl);

    // ignore: use_build_context_synchronously
    this
        .context
        .read<VisionResultProvider>()
        .setGeopositionCoordinate(lat: localLat, long: localLong);

    // ignore: use_build_context_synchronously
    this
        .context
        .read<VisionResultProvider>()
        .setGeopositionCoordinate(lat: localLat, long: localLong);

    final id = this.context.read<UserProvider>().id;

    this.context.read<VisionResultProvider>().setUidUser(value: id);

    FirestoreStorage _storage = FirestoreStorage();

    // ignore: use_build_context_synchronously
    XFile? localFile = context.read<VisioPositionProvider>().image;
    //final _localPath = File(localFile!.path);

    // ignore: use_build_context_synchronously
    String url = await _storage.addFile(localFile!, "");

    context.read<VisionResultProvider>().setUrlImage(value: url);

    // ignore: use_build_context_synchronously
    await dbStore.addResult(context.read<VisionResultProvider>());
  }

  @override
  Widget build(BuildContext context) {
    VisioPositionProvider visionProvider =
        context.watch<VisioPositionProvider>();
    AppStateProvider appStateProvider = context.watch<AppStateProvider>();
    GeoPositionProvider geopositionProvider =
        context.watch<GeoPositionProvider>();
    VisionResultProvider visionresultprovider =
        context.watch<VisionResultProvider>();

    UserProvider visionruserprovider = context.watch<UserProvider>();

    // ignore: non_constant_identifier_names
    Future<void> ClearPaneControl() async {
      this.context.read<VisioPositionProvider>().clearTextCustomPanelControl();
      this
          .context
          .read<VisioPositionProvider>()
          .setTextCustomPanelControl(value: "Result \n\n");
    }

    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Visual Position",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SlidingPanel(
        image: visionProvider.image,
        textCustomPanelControl: visionProvider.textCustomPanelControl,
        panelController: panelController,
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: FloatingActionButton(
              heroTag: const Text("two"),
              onPressed: () async {
                ClearPaneControl();
                if (panelController.isAttached) panelController.close();
                this.context.read<VisioPositionProvider>().setImage(
                    value:
                        await _picker.pickImage(source: ImageSource.gallery));
                // ignore: use_build_context_synchronously
                this.context.read<AppStateProvider>().setIsBusy(value: false);
                // ignore: use_build_context_synchronously
                processImage(
                    InputImage.fromFile(File(visionProvider.image!.path)),
                    context);
                if (panelController.isAttached) panelController.open();
              },
              backgroundColor: Colors.blue,
              child: const Icon(Icons.image),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: FloatingActionButton(
              heroTag: const Text("three"),
              onPressed: () async {
                ClearPaneControl();
                this.context.read<VisioPositionProvider>().setImage(
                    value: await _picker.pickImage(source: ImageSource.camera));
                // ignore: use_build_context_synchronously
                this.context.read<AppStateProvider>().setIsBusy(value: false);
                // ignore: use_build_context_synchronously
                processImage(
                    InputImage.fromFile(File(visionProvider.image!.path)),
                    context);
                if (panelController.isAttached) panelController.open();
              },
              backgroundColor: Colors.blue,
              child: const Icon(Icons.camera),
            ),
          ),
        ],
      ),
    );
  }

  void _initializeLabeler(BuildContext context) {
    final ImageLabelerOptions options =
        ImageLabelerOptions(confidenceThreshold: 0.5);

    imageLabeler = ImageLabeler(options: options);

    context.read<AppStateProvider>().setCanProcess(value: false);
  }

  Future<void> processImage(InputImage inputImage, BuildContext context) async {
    String lableresult = "";
    String text = "";
    List<String> listText = [];
    List<String> listLabel = [];

    if (context.read<AppStateProvider>().isBusy) return;
    if (!context.read<AppStateProvider>().canProcess) return;

    context.read<AppStateProvider>().setIsBusy(value: true);
    context.read<VisioPositionProvider>().setLableresult(value: "");
    _initializeLabeler(context);
    final labels = await imageLabeler.processImage(inputImage);

    // ignore: use_build_context_synchronously
    //context.read<VisionResultProvider>().setImageLabel(value: labels);

    // ignore: use_build_context_synchronously
    context
        .read<VisioPositionProvider>()
        .setTextCustomPanelControl(value: "Recognized label:\n\n");

    lableresult = "Recognized labels: \n";

    for (final label in labels) {
      lableresult =
          '${lableresult}Label: ${label.label}, Confidence: ${label.confidence.toStringAsFixed(2)}\n';

      listLabel.add("${label.label} - ${label.confidence}");
    }
    // ignore: use_build_context_synchronously
    context
        .read<VisioPositionProvider>()
        .setTextCustomPanelControl(value: lableresult);

    context.read<VisionResultProvider>().setImageLabel(value: listLabel);

    final recognizedText = await _textRecognizer.processImage(inputImage);
    // ignore: use_build_context_synchronously

    //final List<String> _listText,

    /*context
        .read<VisionResultProvider>()
        .setRecognizedText(value: recognizedText); */

    text = '\nRecognized text:\n';
    for (var i = 0; i < recognizedText.blocks.length; i++) {
      if (recognizedText.blocks.length != null) {
        text = '${text}block $i: ${recognizedText.blocks[i].text}\n';
        listText.add(recognizedText.blocks[i].text);
      }
    }

    context.read<VisionResultProvider>().setRecognizedText(value: listText);

    // ignore: use_build_context_synchronously
    if (context.read<VisioPositionProvider>().textCustomPanelControl != null) {
      // ignore: use_build_context_synchronously
      context.read<VisioPositionProvider>().setTextCustomPanelControl(
          // ignore: use_build_context_synchronously
          value: context.read<VisioPositionProvider>().textCustomPanelControl! +
              text);
    } else {
      // ignore: use_build_context_synchronously
      context
          .read<VisioPositionProvider>()
          .setTextCustomPanelControl(value: text);
    }

    if (haspermission) {
      // ignore: use_build_context_synchronously
      getLocation(context);
      // ignore: use_build_context_synchronously
    }
    // ignore: use_build_context_synchronously
  }
}
