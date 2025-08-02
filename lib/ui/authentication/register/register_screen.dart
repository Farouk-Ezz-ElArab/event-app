import 'package:event_app/l10n/app_localizations.dart';
import 'package:event_app/providers/app_language_provider.dart';
import 'package:event_app/providers/app_theme_provider.dart';
import 'package:event_app/ui/home/widgets/custom_elevated_button.dart';
import 'package:event_app/ui/home/widgets/custom_text_field.dart';
import 'package:event_app/utils/alert_dialog.dart';
import 'package:event_app/utils/app_assets.dart';
import 'package:event_app/utils/app_colors.dart';
import 'package:event_app/utils/app_routes.dart';
import 'package:event_app/utils/app_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  TextEditingController emailController = TextEditingController(
    text: 'farouk@gmail.com',
  );
  TextEditingController passwordController = TextEditingController(
    text: 'farouk11',
  );
  TextEditingController rePasswordController = TextEditingController(
    text: 'farouk11',
  );
  TextEditingController nameController = TextEditingController(text: 'farouk');
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var screenSize = MediaQuery.of(context).size;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).disabledColor),
        centerTitle: true,
        backgroundColor: AppColors.transparentColor,
        title: Text(
          AppLocalizations.of(context)!.register,
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.03),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(AppAssets.loginLogo, height: screenSize.height * 0.2),
              SizedBox(height: screenSize.height * 0.04),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomTextField(
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'please Enter Name';
                        }
                        return null;
                      },
                      controller: nameController,
                      hintStyle: Theme.of(context).textTheme.bodySmall,
                      prefixIcon: Image.asset(
                        AppAssets.personLoginIcon,
                        color: Theme.of(context).cardColor,
                      ),
                      hintText: AppLocalizations.of(context)!.name,
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(height: screenSize.height * 0.02),
                    CustomTextField(
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'please Enter Email';
                        }
                        final bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                        ).hasMatch(text);
                        if (!emailValid) {
                          return 'please Enter Valid Email';
                        }
                        return null;
                      },
                      controller: emailController,
                      hintStyle: Theme.of(context).textTheme.bodySmall,
                      prefixIcon: Image.asset(
                        AppAssets.emailIcon,
                        color: Theme.of(context).cardColor,
                      ),
                      hintText: AppLocalizations.of(context)!.email,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: screenSize.height * 0.02),
                    CustomTextField(
                      obscureText: true,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'please Enter Password';
                        }
                        if (text.length < 8) {
                          return 'Password should be at least 8 characters';
                        }
                        return null;
                      },
                      controller: passwordController,
                      hintStyle: Theme.of(context).textTheme.bodySmall,
                      prefixIcon: Image.asset(
                        AppAssets.passwordIcon,
                        color: Theme.of(context).cardColor,
                      ),
                      hintText: AppLocalizations.of(context)!.password,
                      suffixIcon: Image.asset(
                        AppAssets.showPasswordIcon,
                        color: Theme.of(context).cardColor,
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: screenSize.height * 0.02),
                    CustomTextField(
                      obscureText: true,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'please Enter Re-Password';
                        }
                        if (text.length < 8) {
                          return 'Password should be at least 8 characters';
                        }
                        if (passwordController.text != text) {
                          return 'password and Re-Password should be the same';
                        }

                        return null;
                      },
                      controller: rePasswordController,
                      hintStyle: Theme.of(context).textTheme.bodySmall,
                      prefixIcon: Image.asset(
                        AppAssets.passwordIcon,
                        color: Theme.of(context).cardColor,
                      ),
                      hintText: AppLocalizations.of(context)!.re_password,
                      suffixIcon: Image.asset(
                        AppAssets.showPasswordIcon,
                        color: Theme.of(context).cardColor,
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: screenSize.height * 0.02),

                    CustomElevatedButton(
                      buttonText: AppLocalizations.of(context)!.create_account,
                      onPressed: () {
                        register(context);
                      },
                    ),
                    SizedBox(height: screenSize.height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.already_have_account,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        TextButton(
                          style: ButtonStyle(
                            padding: WidgetStatePropertyAll(EdgeInsets.zero),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            AppLocalizations.of(context)!.login,
                            style: AppStyles.bold16Primary.copyWith(
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.primaryLight,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ToggleSwitch(
                          changeOnTap: true,
                          customWidgets: [
                            Image.asset(AppAssets.enIcon),
                            Image.asset(AppAssets.egIcon),
                          ],
                          radiusStyle: true,
                          curve: Curves.fastLinearToSlowEaseIn,
                          animate: true,
                          minWidth: screenSize.width * 0.2,
                          minHeight: screenSize.width * 0.1,
                          initialLabelIndex:
                              languageProvider.appLanguage == 'en' ? 0 : 1,
                          cornerRadius: screenSize.width * 0.5,
                          activeFgColor: Colors.white,
                          inactiveBgColor: Colors.transparent,
                          inactiveFgColor: Colors.white,
                          totalSwitches: 2,
                          borderColor: [AppColors.primaryLight],
                          dividerColor: Colors.transparent,
                          activeBgColors: [
                            [Colors.blue, Colors.lightBlueAccent],
                            [Colors.red, Colors.black],
                          ],
                          onToggle: (index) {
                            if (index == 0) {
                              languageProvider.changeLanguage('en');
                            } else if (index == 1) {
                              languageProvider.changeLanguage('ar');
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  register(BuildContext context) async {
    int flag = 0;
    if (formKey.currentState?.validate() == true) {
      //todo show loading
      DialogUtils.showLoading(context: context, loadingText: 'loading...');
      try {
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        //todo: hide loading
        DialogUtils.hideLoading(context: context);
        //todo show message
        DialogUtils.showMessage(
            context: context,
            message: 'Register Successfully',
            title: 'Success',
            postActionName: 'Next',
            posAction: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.homeScreenRouteName,
                    (route) => false,
              );
            }
        );
      } on FirebaseAuthException catch (e) {
        flag++;
        if (e.code == 'weak-password') {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(
            context: context,
            message: 'The password provided is too weak.',
            title: 'Error',
            postActionName: 'Ok',
          );
        } else if (e.code == 'email-already-in-use') {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(
            context: context,
            message: 'The account already exists for that email.',
            title: 'Error',
            postActionName: 'Ok',
          );
        }
        else if (e.code == 'network-request-failed') {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(
            context: context,
            message: 'No internet Connection.',
            title: 'Error',
            postActionName: 'Ok',
          );
        }
      } catch (e) {
        DialogUtils.hideLoading(context: context);
        DialogUtils.showMessage(
          context: context,
          message: e.toString(),
          title: 'Error',
          postActionName: 'Ok',
        );
      }
    }
  }
}
