import 'package:firebase_auth/firebase_auth.dart';

class FireAuth {
  // For registering a new user
  static Future<User?> registerUsingEmailPassword(
      {required String name,
      required String email,
      required String password,
      String? urlphoto}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      user = userCredential.user;
      await user!.updateDisplayName(name);
      await user.updatePhotoURL(urlphoto);

      await user.reload();
      user = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('ERROR: The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('ERROR: The account already exists for that email.');
      }
    } catch (e) {
      print("ERROR: " + e.toString());
    }

    return user;
  }

  static Future<dynamic> LogoutFromApp() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.signOut();
  }

  // For signing in an user (have already registered)
  static Future<User?> signInUsingEmailPassword({
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
      }
    }

    return user;
  }

  static Future<User?> refreshUser(User user) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await user.reload();
    User? refreshedUser = auth.currentUser;

    return refreshedUser;
  }
}
