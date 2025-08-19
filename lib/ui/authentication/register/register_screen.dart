import 'package:event_app/l10n/app_localizations.dart';
import 'package:event_app/providers/app_language_provider.dart';
import 'package:event_app/providers/app_theme_provider.dart';
import 'package:event_app/ui/authentication/register/register_navigator.dart';
import 'package:event_app/ui/authentication/register/register_screen_view_model.dart';
import 'package:event_app/ui/home/widgets/custom_elevated_button.dart';
import 'package:event_app/ui/home/widgets/custom_text_field.dart';
import 'package:event_app/utils/alert_dialog.dart';
import 'package:event_app/utils/app_assets.dart';
import 'package:event_app/utils/app_colors.dart';
import 'package:event_app/utils/app_routes.dart';
import 'package:event_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class RegisterScreen extends StatefulWidget {

  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    implements RegisterNavigator {
  RegisterScreenViewModel viewModel = RegisterScreenViewModel();

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

  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
  }


  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var screenSize = MediaQuery.of(context).size;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Theme
              .of(context)
              .disabledColor),
          centerTitle: true,
          backgroundColor: AppColors.transparentColor,
          title: Text(
            AppLocalizations.of(context)!.register,
            style: Theme
                .of(context)
                .textTheme
                .displayMedium,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.03),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                    AppAssets.loginLogo, height: screenSize.height * 0.2),
                SizedBox(height: screenSize.height * 0.04),
                Form(
                  key: viewModel.formKey,
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
                        hintStyle: Theme
                            .of(context)
                            .textTheme
                            .bodySmall,
                        prefixIcon: Image.asset(
                          AppAssets.personLoginIcon,
                          color: Theme
                              .of(context)
                              .cardColor,
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
                        hintStyle: Theme
                            .of(context)
                            .textTheme
                            .bodySmall,
                        prefixIcon: Image.asset(
                          AppAssets.emailIcon,
                          color: Theme
                              .of(context)
                              .cardColor,
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
                        hintStyle: Theme
                            .of(context)
                            .textTheme
                            .bodySmall,
                        prefixIcon: Image.asset(
                          AppAssets.passwordIcon,
                          color: Theme
                              .of(context)
                              .cardColor,
                        ),
                        hintText: AppLocalizations.of(context)!.password,
                        suffixIcon: Image.asset(
                          AppAssets.showPasswordIcon,
                          color: Theme
                              .of(context)
                              .cardColor,
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
                        hintStyle: Theme
                            .of(context)
                            .textTheme
                            .bodySmall,
                        prefixIcon: Image.asset(
                          AppAssets.passwordIcon,
                          color: Theme
                              .of(context)
                              .cardColor,
                        ),
                        hintText: AppLocalizations.of(context)!.re_password,
                        suffixIcon: Image.asset(
                          AppAssets.showPasswordIcon,
                          color: Theme
                              .of(context)
                              .cardColor,
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: screenSize.height * 0.02),

                      CustomElevatedButton(
                        buttonText: AppLocalizations.of(context)!
                            .create_account,
                        onPressed: () {
                          viewModel.register(emailController.text,
                              passwordController.text);
                        },
                      ),
                      SizedBox(height: screenSize.height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.already_have_account,
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyMedium,
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
      ),
    );
  }


  @override
  void hideLoading() {
    DialogUtils.hideLoading(context: context);
  }

  @override
  void showLoading(String loadingText) {
    DialogUtils.showLoading(context: context, loadingText: loadingText);
  }

  @override
  void showMessage(String message) {
    DialogUtils.showMessage(
        context: context, message: message, postActionName: 'Ok');
  }

  @override
  void navigateToHomeScreen() {
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.homeScreenRouteName, (route) => route.currentResult == false,);
  }
}
