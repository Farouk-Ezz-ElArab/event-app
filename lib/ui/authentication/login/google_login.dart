import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../utils/alert_dialog.dart';
import '../../../utils/app_routes.dart';

class GoogleLogin {
  Future<UserCredential?> signInWithGoogle(BuildContext context) async {
    DialogUtils.showLoading(context: context, loadingText: 'loading...');
    try {
      await GoogleSignIn().signOut();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      DialogUtils.hideLoading(context: context);
      DialogUtils.showMessage(
        context: context,
        message: 'Google Login Successfully',
        title: 'Success',
        postActionName: 'Next',
        posAction: () {
          Navigator.of(
            context,
          ).pushReplacementNamed(AppRoutes.homeScreenRouteName);
        },
      );
      if (googleUser == null) {
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.idToken,
        idToken: googleAuth.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      DialogUtils.hideLoading(context: context);
      DialogUtils.showMessage(
        context: context,
        message: ' Google Sign-In Error: $e',
        title: 'Error',
        postActionName: 'Ok',
      );
      return null;
    }
  }
}
