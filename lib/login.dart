import 'package:chess_game/authentication/auth_services.dart';
import 'package:chess_game/authentication/secure_storage.dart';
import 'package:chess_game/utils/color_utils.dart';
import 'package:chess_game/utils/display_snackBar.dart';
import 'package:chess_game/utils/route_const.dart';
import 'package:chess_game/utils/route_generator.dart';
import 'package:chess_game/utils/spin_kit.dart';
import 'package:chess_game/utils/string_utils.dart';
import 'package:chess_game/widgets/customInkwell.dart';
import 'package:chess_game/widgets/custom_elevatedButton.dart';
import 'package:chess_game/widgets/custom_text.dart';
import 'package:chess_game/widgets/custom_textFormField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LocalAuthentication auth = LocalAuthentication();
  final AuthServices authServices = AuthServices();
  final TextEditingController _emailAddressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  bool rememberMe = false;
  bool loader = false;

  checkAuth() async {
    bool isAvailable;
    isAvailable = await auth.canCheckBiometrics;
    print(isAvailable);
    if (isAvailable) {
      bool result = await auth.authenticate(
        biometricOnly: true,

        localizedReason: "Scan you fingerprint to Proceed",
      );
      if (result) {
        RouteGenerator.navigateToPage(context, Routes.bottomNavBarRoute);
      } else {
        DisplaySnackbar.show(context, deniedPermissionStr);
      }
    } else {
      print(noBiometricsDetectedStr);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ui(),
          loader ? Loader.backdropFilter(context) : const SizedBox(),
        ],
      ),
    );
  }

  Widget ui() => SafeArea(
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              CircleAvatar(
                backgroundColor: foregroundColor,
                child: IconButton(
                  onPressed: () {
                    RouteGenerator.navigateToPage(context, Routes.signupRoute);
                  },
                  icon: Icon(Icons.close),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: CustomText(
                  data: welcomeBackStr,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),

              CustomTextformfield(
                controller: _emailAddressController,
                hintText: emailAddressStr,
                validator: (p0) {
                  if (p0 == null || p0.isEmpty) {
                    return validateEmailAddressStr;
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              CustomTextformfield(
                obscureText: _isPasswordVisible ? false : true,
                controller: _passwordController,
                hintText: passwordStr,
                validator: (p0) {
                  if (p0 == null || p0.isEmpty) {
                    return validatePasswordStr;
                  }
                  return null;
                },
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: _isPasswordVisible ? Colors.green : Colors.grey,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: CustomInkwell(
                  onTap: () {
                    checkAuth();
                  },
                  child: CustomText(data: fingerprintLoginStr),
                ),
              ),
              SizedBox(height: 10),

              // Center(child: const FingerprintLoginButton()),
              Row(
                children: [
                  Checkbox(
                    value: rememberMe,
                    onChanged: (bool? value) {
                      setState(() {
                        rememberMe = value! ? true : false;
                      });
                    },
                  ),
                  CustomText(data: rememberMeStr),
                  Spacer(),
                  CustomInkwell(
                    onTap: () {
                      RouteGenerator.navigateToPage(
                        context,
                        Routes.forgotPasswordRoute,
                      );
                    },
                    child: Text(
                      forgotPasswordStr,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
              CustomElevatedbutton(
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      loader = true;
                    });
                    try {
                      UserCredential userCredential = await authServices.login(
                        email: _emailAddressController.text.trim(),
                        password: _passwordController.text.trim(),
                      );
                      final storage = SecureStorage();
                      if (userCredential.user != null) {
                        await storage.saveUser(userCredential.user!.uid);
                      }

                      RouteGenerator.navigateToPage(
                        context,
                        Routes.bottomNavBarRoute,
                      );
                      DisplaySnackbar.show(context, loginSuccessfullStr);
                    } catch (e) {
                      DisplaySnackbar.show(context, e.toString());
                      DisplaySnackbar.show(context, loginFailedStr);
                    }
                    setState(() {
                      loader = false;
                    });
                    // Future.delayed(Duration(seconds: 2), () async {
                    //   FirebaseFirestore firestore =
                    //       FirebaseFirestore.instance;
                    //   await firestore
                    //       .collection("Register")
                    //       .where(
                    //         "email",
                    //         isEqualTo: _emailAddressController.text.trim(),
                    //       )
                    //       .where(
                    //         "password",
                    //         isEqualTo: _passwordController.text.trim(),
                    //       )
                    //       .get()
                    //       .then((value) async {
                    //         if (value.docs.isNotEmpty) {
                    //           if (rememberMe) {
                    //             final prefs =
                    //                 await SharedPreferences.getInstance();
                    //             await prefs.setBool('isLoggedIn', true);
                    //           }
                    //           DisplaySnackbar.show(
                    //             context,
                    //             loginSuccessfullStr,
                    //           );
                    //           RouteGenerator.navigateToPageWithoutStack(
                    //             context,
                    //             Routes.bottomNavBarRoute,
                    //           );
                    //         } else {
                    //           DisplaySnackbar.show(context, loginFailedStr);
                    //         }
                    //         setState(() => loader = false);
                    //       })
                    //       .catchError((error) {
                    //         setState(() => loader = false);
                    //         ScaffoldMessenger.of(context).showSnackBar(
                    //           SnackBar(content: Text(sameStr)),
                    //         );
                    //       });
                    // });
                  }
                },
                child: Text(loginStr),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: Divider()),
                  Text("Or"),
                  Expanded(child: Divider()),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomElevatedbutton(
                    onPressed: () {},
                    width: MediaQuery.of(context).size.width * 0.25,
                    backgroundColor: Colors.white,
                    child: Image.asset("assets/images/google_logo.png"),
                  ),
                  SizedBox(width: 30),
                  CustomElevatedbutton(
                    onPressed: () {},
                    width: MediaQuery.of(context).size.width * 0.25,
                    backgroundColor: Colors.white,
                    child: Image.asset(
                      "assets/images/facebook_logo.png",
                      height: 40,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Spacer(),
                  CustomText(data: dontHAveanAccountStr, fontSize: 20),
                  CustomInkwell(
                    child: CustomText(
                      data: SignupStr,
                      color: primaryColor,
                      fontSize: 20,
                    ),
                    onTap: () {
                      RouteGenerator.navigateToPage(
                        context,
                        Routes.signupRoute,
                      );
                    },
                  ),
                  Spacer(),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
