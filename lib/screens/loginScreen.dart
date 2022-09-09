import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebasemlkit/classes/userprovider.dart';
import 'package:firebasemlkit/screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebasemlkit/screens/signUpScreen.dart';
import 'package:firebasemlkit/widgets/inputTextWidget.dart';
import 'package:provider/provider.dart';

import '../classes/userprovider.dart';
import '../utils/authfirebase.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen() : super();

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<LoginScreen> {
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      //  Get.to(const HomeScreen());
    }
    return firebaseApp;
  }

  final TextEditingController _pwdController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  //final snackBar = SnackBar(content: Text('email ou mot de passe incorrect'));
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();

    future:
    _initializeFirebase();
    final screenWidth = MediaQuery.of(context).size.width;
    const double r = (175 / 360); //  rapport for web test(304 / 540);
    final coverHeight = screenWidth * r;
    bool _pinned = false;
    bool _snap = false;
    bool _floating = false;
    bool _isloading = false;

    final widgetList = [
      Row(
        children: const [
          SizedBox(
            width: 28,
          ),
          Text(
            'Bienvenido',
            style: TextStyle(
              fontFamily: 'Segoe UI',
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Color(0xff000000),
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
      const SizedBox(
        height: 12.0,
      ),
      Form(
          key: _formKey,
          child: Column(
            children: [
              InputTextWidget(
                  controller: _emailController,
                  labelText: "Email Addres",
                  icon: Icons.email,
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress),
              const SizedBox(
                height: 12.0,
              ),
              InputTextWidget(
                  controller: _pwdController,
                  labelText: "Your Password",
                  icon: Icons.lock,
                  obscureText: true,
                  keyboardType: TextInputType.text),
              Padding(
                padding: const EdgeInsets.only(right: 25.0, top: 10.0),
                child: Align(
                    alignment: Alignment.topRight,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {},
                        child: Text(
                          "Lost password ?",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700]),
                        ),
                      ),
                    )),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Container(
                height: 55.0,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      User? user = await FireAuth.signInUsingEmailPassword(
                        email: _emailController.text,
                        password: _pwdController.text,
                      );
                      if (user != null) {
                        this.context.read<UserProvider>().setUser(
                            email: user.email,
                            displyname: user.displayName,
                            urlphoto: user.photoURL);

                        print(userProvider.email);
                        Get.to(const HomeScreen());
                      } else {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text("Ops! Login Failed"),
                            content: const Text("Ops! Login Failed"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                                child: const Text('Okay'),
                              )
                            ],
                          ),
                        );
                      }
                    }
                    //Get.to(ChoiceScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    elevation: 0.0,
                    minimumSize: Size(screenWidth, 150),
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(0)),
                    ),
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                        boxShadow: const <BoxShadow>[
                          BoxShadow(
                              color: Colors.red,
                              offset: Offset(1.1, 1.1),
                              blurRadius: 10.0),
                        ],
                        color: Colors.red, // Color(0xffF05945),
                        borderRadius: BorderRadius.circular(12.0)),
                    child: Container(
                      alignment: Alignment.center,
                      child: const Text(
                        "Sign In",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
      const SizedBox(
        height: 15.0,
      ),
      Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 10.0, top: 15.0),
            child: Container(
              decoration: BoxDecoration(
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey, //Color(0xfff05945),
                        offset: Offset(0, 0),
                        blurRadius: 5.0),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0)),
              width: (screenWidth / 2) - 40,
              height: 55,
              child: Material(
                borderRadius: BorderRadius.circular(12.0),
                child: InkWell(
                  onTap: () {
                    print("facebook tapped");
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Image.asset("assets/images/fb.png", fit: BoxFit.cover),
                        const SizedBox(
                          width: 7.0,
                        ),
                        const Text("Sign in with\nfacebook")
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 30.0, top: 15.0),
            child: Container(
              decoration: BoxDecoration(
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey, //Color(0xfff05945),
                        offset: Offset(0, 0),
                        blurRadius: 5.0),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0)),
              width: (screenWidth / 2) - 40,
              height: 55,
              child: Material(
                borderRadius: BorderRadius.circular(12.0),
                child: InkWell(
                  onTap: () {
                    print("google tapped");
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Image.asset("assets/images/google.png",
                            fit: BoxFit.cover),
                        const SizedBox(
                          width: 7.0,
                        ),
                        Text("Sign in with\nGoogle")
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 15.0,
      ),
    ];
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: _pinned,
            snap: _snap,
            floating: _floating,
            expandedHeight: coverHeight - 25, //304,
            backgroundColor: Color(0xFFdccdb4),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              background:
                  Image.asset("assets/images/cover.png", fit: BoxFit.cover),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(),
                  gradient: LinearGradient(
                      colors: <Color>[Color(0xFFdccdb4), Color(0xFFd8c3ab)])),
              width: screenWidth,
              height: 25,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: screenWidth,
                    height: 25,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverList(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
            return widgetList[index];
          }, childCount: widgetList.length))
        ],
      ),
      bottomNavigationBar: Stack(
        children: [
          Container(
            height: 50.0,
            color: Colors.white,
            child: Center(
                child: Wrap(
              children: [
                Text(
                  "Don't have an account?  ",
                  style: TextStyle(
                      color: Colors.grey[600], fontWeight: FontWeight.bold),
                ),
                Material(
                    child: InkWell(
                  onTap: () {
                    print("sign up tapped");
                    Get.to(SignUpScreen());
                  },
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.blue[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                )),
              ],
            )),
          ),
        ],
      ),
    );
  }
}
