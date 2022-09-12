import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebasemlkit/screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebasemlkit/widgets/inputTextWidget.dart';
import 'package:provider/provider.dart';

import '../classes/userprovider.dart';
import '../utils/authfirebase.dart';
import 'loginScreen.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen() : super();

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _customerNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up",
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Segoe UI',
              fontSize: 30,
              shadows: [
                Shadow(
                  color: Color(0xba000000),
                  offset: Offset(0, 3),
                  blurRadius: 6,
                )
              ],
            )),
        //centerTitle: true,
        leading: InkWell(
          onTap: () => Get.to(const LoginScreen()),
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          width: screenWidth,
          height: screenHeight,
          child: SingleChildScrollView(
            //controller: controller,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 30.0,
                  ),
                  const Text(
                    'Welcome to our house!!',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff000000),
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  InputTextWidget(
                      controller: _nameController,
                      labelText: "First name",
                      icon: Icons.person,
                      obscureText: false,
                      keyboardType: TextInputType.text),
                  const SizedBox(
                    height: 12.0,
                  ),
                  const InputTextWidget(
                      labelText: "Last Name",
                      icon: Icons.person,
                      obscureText: false,
                      keyboardType: TextInputType.text),
                  const SizedBox(
                    height: 12.0,
                  ),
                  InputTextWidget(
                      controller: _emailController,
                      labelText: "E-mail address",
                      icon: Icons.email,
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress),
                  const SizedBox(
                    height: 12.0,
                  ),
                  InputTextWidget(
                      controller: _customerNumber,
                      labelText: "Telephone number",
                      icon: Icons.phone,
                      obscureText: false,
                      keyboardType: TextInputType.number),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                    child: Container(
                      child: Material(
                        elevation: 15.0,
                        shadowColor: Colors.black,
                        borderRadius: BorderRadius.circular(15.0),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(right: 20.0, left: 15.0),
                          child: TextFormField(
                              obscureText: true,
                              autofocus: false,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                icon: Icon(
                                  Icons.lock,
                                  color: Colors.black,
                                  size: 32.0, /*Color(0xff224597)*/
                                ),
                                labelText: "Passwords",
                                labelStyle: TextStyle(
                                    color: Colors.black54, fontSize: 18.0),
                                hintText: '',
                                enabledBorder: InputBorder.none,
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black54),
                                ),
                                border: InputBorder.none,
                              ),
                              controller: _pass,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'type a password';
                                } else if (val.length < 6) {
                                  return 'password must be > 6 characters';
                                }

                                return null;
                              }),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                    child: Container(
                      child: Material(
                        elevation: 15.0,
                        shadowColor: Colors.black,
                        borderRadius: BorderRadius.circular(15.0),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(right: 20.0, left: 15.0),
                          child: TextFormField(
                              obscureText: true,
                              autofocus: false,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                icon: Icon(
                                  Icons.lock,
                                  color: Colors.black,
                                  size: 32.0, /*Color(0xff224597)*/
                                ),
                                labelText: "Confirm Passwords",
                                labelStyle: TextStyle(
                                    color: Colors.black54, fontSize: 18.0),
                                hintText: '',
                                enabledBorder: InputBorder.none,
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black54),
                                ),
                                border: InputBorder.none,
                              ),
                              controller: _confirmPass,
                              validator: (val) {
                                if (val!.isEmpty) return 'confirm password!!';
                                if (val != _pass.text)
                                  return 'Incorrect password';
                                return null;
                              }),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    height: 55.0,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          User? user =
                              await FireAuth.registerUsingEmailPassword(
                            email: _emailController.text,
                            password: _pass.text,
                            name: _nameController.text,
                            phoneNumber: _customerNumber.text,
                          );
                          if (user != null) {
                            this.context.read<UserProvider>().setUser(
                                email: _emailController.text,
                                displyname: _nameController.text,
                                urlphoto: user.photoURL,
                                phoneNumber: _customerNumber.text);
                            Get.to(const HomeScreen());
                          } else {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text("Ops! Registration Failed"),
                                content: const Text("Ops! Registration Failed"),
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
                                  color: Color(0xfff05945),
                                  offset: Offset(1.1, 1.1),
                                  blurRadius: 10.0),
                            ],
                            color: const Color(0xffF05945),
                            borderRadius: BorderRadius.circular(12.0)),
                        child: Container(
                          alignment: Alignment.center,
                          child: const Text(
                            "Register",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
