import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthGmailService {
  static AuthGmailService? _obj;
  AuthGmailService._();
  static AuthGmailService get obj => _obj ??= AuthGmailService._();
  handleAuthState() {
    debugPrint("handle auth state ");
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          // if (snapshot.hasData) {
          //   // return const HomeScreen();
          // } else {
          // }
          return Container();
        });
  }

  Future<GoogleSignInAccount?> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email'],
        clientId: Platform.isIOS
            ? "150269270635-qf8mv4hj8jicp1jq68c1vetddtcombad.apps.googleusercontent.com"
            : null,
      );
      await googleSignIn.signOut();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      debugPrint("user : $googleUser");
      if (googleUser == null) {
        return null; // User canceled the sign-in
      }
      return googleUser;
    } catch (e) {
      debugPrint("Error signing in: $e");
      return null;
    }
  }

  signOut() async {
    await FirebaseAuth.instance.signOut();
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
  }
}
