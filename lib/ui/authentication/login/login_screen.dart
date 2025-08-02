import 'package:event_app/l10n/app_localizations.dart';
import 'package:event_app/providers/app_language_provider.dart';
import 'package:event_app/ui/authentication/login/google_login.dart';
import 'package:event_app/ui/home/widgets/custom_elevated_button.dart';
import 'package:event_app/ui/home/widgets/custom_text_field.dart';
import 'package:event_app/utils/app_assets.dart';
import 'package:event_app/utils/app_colors.dart';
import 'package:event_app/utils/app_routes.dart';
import 'package:event_app/utils/app_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../utils/alert_dialog.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  TextEditingController emailController = TextEditingController(
    text: 'farouk@gmail.com',
  );
  TextEditingController passwordController = TextEditingController(
    text: 'farouk11',
  );
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.03),
          child: SingleChildScrollView(
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  AppAssets.loginLogo,
                  height: screenSize.height * 0.2,
                ),
                SizedBox(height: screenSize.height * 0.04),
                Form(
                  key: formKey,
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
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
                      SizedBox(height: screenSize.height * 0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            style: ButtonStyle(),
                            onPressed: () {
                              //TODO: Navigate to forget password screen
                            },
                            child: Text(
                              AppLocalizations.of(
                                context,
                              )!.forget_password_question,
                              style: AppStyles.bold16Primary.copyWith(
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.primaryLight,
                              ),
                            ),
                          ),
                        ],
                      ),
                      CustomElevatedButton(
                        buttonText: AppLocalizations.of(context)!.login,
                        onPressed: () {
                          login(context);
                        },
                      ),
                      SizedBox(height: screenSize.height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.dont_have_account,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          SizedBox(width: screenSize.width * 0.015),
                          TextButton(
                            style: ButtonStyle(
                              padding: WidgetStatePropertyAll(EdgeInsets.zero),
                            ),
                            onPressed: () {
                              Navigator.of(
                                context,
                              ).pushNamed(AppRoutes.registerScreenRouteName);
                            },
                            child: Text(
                              AppLocalizations.of(context)!.create_account,
                              style: AppStyles.bold16Primary.copyWith(
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.primaryLight,
                              ),
                            ),
                          ),
                        ],
                      ),
                      //SizedBox(height: screenSize.height * 0.02),
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              height: screenSize.height * 0.04,
                              color: AppColors.primaryLight,
                              thickness: 1,
                              indent: screenSize.width * 0.05,
                              endIndent: screenSize.width * 0.05,
                            ),
                          ),
                          Text(
                            AppLocalizations.of(context)!.or,
                            style: AppStyles.medium16Primary,
                          ),
                          Expanded(
                            child: Divider(
                              height: screenSize.height * 0.04,
                              color: AppColors.primaryLight,
                              thickness: 1,
                              indent: screenSize.width * 0.05,
                              endIndent: screenSize.width * 0.05,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenSize.height * 0.02),
                      CustomElevatedButton(
                        leadingIcon: Image.asset(AppAssets.googleIcon),
                        buttonTextStyle: AppStyles.medium16Primary,
                        buttonColor: AppColors.transparentColor,
                        buttonText: AppLocalizations.of(
                          context,
                        )!.login_with_google,
                        onPressed: () {
                          GoogleLogin().signInWithGoogle(context);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenSize.height * 0.02),
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
                      initialLabelIndex: languageProvider.appLanguage == 'en'
                          ? 0
                          : 1,
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
        ),
      ),
    );
  }

  login(BuildContext context) async {
    if (formKey.currentState?.validate() == true) {
      //todo show loading
      DialogUtils.showLoading(context: context, loadingText: 'Login...');
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            );
        //todo: hide loading
        DialogUtils.hideLoading(context: context);
        //todo show message
        DialogUtils.showMessage(
          context: context,
          message: 'Login Successfully',
          title: 'Success',
          postActionName: 'Next',
          posAction: () {
            Navigator.of(
              context,
            ).pushReplacementNamed(AppRoutes.homeScreenRouteName);
          },
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
          //todo: hide loading
          DialogUtils.hideLoading(context: context);
          //todo show message
          DialogUtils.showMessage(
            context: context,
            message:
                'The supplied auth credential is incorrect, malformed or has expired.',
            title: 'Error',
            postActionName: 'Ok',
          );
        } else if (e.code == 'network-request-failed') {
          //todo: hide loading
          DialogUtils.hideLoading(context: context);
          //todo show message
          DialogUtils.showMessage(
            context: context,
            message: 'No internet Connection.',
            title: 'Error',
            postActionName: 'Ok',
          );
        }
      } catch (e) {
        //todo: hide loading
        DialogUtils.hideLoading(context: context);
        //todo show message
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
