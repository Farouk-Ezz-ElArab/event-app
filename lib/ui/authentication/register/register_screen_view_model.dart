import 'package:event_app/ui/authentication/register/register_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreenViewModel extends ChangeNotifier {
  late RegisterNavigator navigator;
  var formKey = GlobalKey<FormState>();

  void register(String email, String password) async {
    if (formKey.currentState?.validate() == true) {
      navigator.showLoading('loading...');
      try {
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        navigator.hashCode;
        navigator.showMessage('Register Successfully');
        navigator.navigateToHomeScreen();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          navigator.hideLoading();
          navigator.showMessage('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          navigator.hideLoading();
          navigator.showMessage('The account already exists for that email.');
        } else if (e.code == 'network-request-failed') {
          navigator.hideLoading();
          navigator.showMessage('No internet Connection.');
        }
      } catch (e) {
        navigator.hideLoading();
        navigator.showMessage(e.toString());
      }
    }
  }
}
