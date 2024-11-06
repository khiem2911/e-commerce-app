import 'package:ecommerce_app/route/route_constant.dart';
import 'package:ecommerce_app/services/api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Google {
  signInWithGoole(BuildContext context) async {
    //sign in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    //auth detail from request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    //create credential for user
    final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken, idToken: gAuth.idToken);

    await FirebaseAuth.instance.signInWithCredential(credential);
    await getItems(context);

    return Navigator.pushNamedAndRemoveUntil(
        context, locationRoute, (Route<dynamic> route) => false);
  }
}
