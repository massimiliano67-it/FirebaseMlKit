import 'package:firebase_core/firebase_core.dart';
import 'package:firebasemlkit/classes/appstateprovider.dart';
import 'package:firebasemlkit/classes/visionpositionprovider.dart';
import 'package:firebasemlkit/firebase_options.dart';
import 'package:firebasemlkit/screens/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'classes/geopositionprovider.dart';
import 'classes/userprovider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
          ChangeNotifierProvider<VisioPositionProvider>(
              create: (_) => VisioPositionProvider()),
          ChangeNotifierProvider<AppStateProvider>(
              create: (_) => AppStateProvider()),
          ChangeNotifierProvider<GeoPositionProvider>(
              create: (_) => GeoPositionProvider()),
        ],
        builder: (context, _) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              // This is the theme of your application.
              //
              // Try running your application with "flutter run". You'll see the
              // application has a blue toolbar. Then, without quitting the app, try
              // changing the primarySwatch below to Colors.green and then invoke
              // "hot reload" (press "r" in the console where you ran "flutter run",
              // or simply save your changes to "hot reload" in a Flutter IDE).
              // Notice that the counter didn't reset back to zero; the application
              // is not restarted.
              primarySwatch: Colors.blue,
              useMaterial3: true,
            ),
            home: const LoginScreen(),
          );
        });
  }
}
