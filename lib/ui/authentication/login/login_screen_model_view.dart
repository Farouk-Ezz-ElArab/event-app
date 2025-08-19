import 'package:event_app/ui/authentication/login/login_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreenModelView extends ChangeNotifier {
  var emailController = TextEditingController(text: 'farouk@gmail.com');
  var passwordController = TextEditingController(text: 'farouk11');
  late LoginNavigator navigator;
  var formKey = GlobalKey<FormState>();

  void login() async {
    if (formKey.currentState?.validate() == true) {
      //todo show loading
      navigator.showLoading('Login...');
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            );
        navigator.hideLoading();
        navigator.showMessage('Login Successfully');
        navigator.navigateToHomeScreen();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
          navigator.hideLoading();
          navigator.showMessage(
            'The supplied auth credential is incorrect, malformed or has expired.',
          );
        } else if (e.code == 'network-request-failed') {
          navigator.hideLoading();
          navigator.showMessage(
            'No internet Connection.No internet Connection.',
          );
        }
      } catch (e) {
        navigator.hideLoading();
        navigator.showMessage(e.toString());
      }
    }
  }
}
