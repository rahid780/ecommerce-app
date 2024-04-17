// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo {
  static Future<void> signUpWithEmailAndPassword(email, password) async {
    final auth = FirebaseAuth.instance;
    await auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  static Future<void> signInWithEmailAndPassword(email, password) async {
    final auth = FirebaseAuth.instance;
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  static Future<void> sendEmailVerification() async {
    final user = FirebaseAuth.instance.currentUser!;
    try {
      await user.sendEmailVerification();
    } catch (e) {
      print(e);
    }
  }

  static get uid {
    User user = FirebaseAuth.instance.currentUser!;
    user.uid;
  }

  static Future<void> updateName(storeName) async {
    User user = FirebaseAuth.instance.currentUser!;
    await user.updateDisplayName(storeName);
  }

  static Future<void> updateStoreLogo(storeLogo) async {
    User user = FirebaseAuth.instance.currentUser!;
    await user.updatePhotoURL(storeLogo);
  }

  static Future<void> reloadUserData() async {
    await FirebaseAuth.instance.currentUser!.reload();
  }

  static Future<bool> checkEmailVerification() async {
    try {
      bool emailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
      return emailVerified == true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<void> logOut() async {
    final auth = FirebaseAuth.instance;
    await auth.signOut();
  }

  static Future<void> sendPasswordResetEmail(email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e);
    }
  }

  static Future<bool> checkOldPassword(email, password) async {
    AuthCredential authCredential =
        EmailAuthProvider.credential(email: email, password: password);

    try {
      var credentialResult = await FirebaseAuth.instance.currentUser!
          .reauthenticateWithCredential(authCredential);
      return credentialResult.user != null;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<void> updateUserPassword(newPassword) async {
    try {
      await FirebaseAuth.instance.currentUser!.updatePassword(newPassword);
    } catch (e) {
      print(e);
    }
  }
}
