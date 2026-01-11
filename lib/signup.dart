import 'package:chess_game/authentication/auth_services.dart';
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
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final AuthServices authServices = AuthServices();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailAddressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  bool isTermsAndConditionedAgreed = false;
  bool loader = false;

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
    child: Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              CircleAvatar(
                backgroundColor: foregroundColor,
                child: IconButton(
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  icon: Icon(Icons.close),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: CustomText(
                  data: createAccountStr,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),

              CustomTextformfield(
                controller: _nameController,
                hintText: nameStr,
                validator: (p0) {
                  if (p0 == null || p0.isEmpty) {
                    return validateNameStr;
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
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
                validator: (p0) {
                  if (p0 == null || p0.isEmpty) {
                    return validatePasswordStr;
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Checkbox(
                    value: isTermsAndConditionedAgreed,
                    onChanged: (value) {
                      setState(() {
                        isTermsAndConditionedAgreed = value ?? false;
                      });
                    },
                  ),
                  CustomText(data: agreeTermsAndConditionStr),
                  Spacer(),
                ],
              ),

              SizedBox(height: 50),
              CustomElevatedbutton(
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }

                  if (!isTermsAndConditionedAgreed) {
                    DisplaySnackbar.show(
                      context,
                      notagreedToTermsAndConditionStr,
                    );
                    return;
                  }

                  setState(() {
                    loader = true;
                  });
                  try {
                    await authServices.signUp(
                      name: _nameController.text.trim(),
                      email: _emailAddressController.text.trim(),
                      password: _passwordController.text.trim(),
                    );
                    RouteGenerator.navigateToPage(context, Routes.bottomNavBarRoute);
                    DisplaySnackbar.show(context, signupSuccessfullStr);
                  } catch (e) {
                    DisplaySnackbar.show(context, e.toString());
                    DisplaySnackbar.show(context, signupFailedStr);
                  }
                  setState(() {
                    loader = false;
                  });

                  //   try {
                  //     var data = {
                  //       "name": _nameController.text.trim(),
                  //       "email": _emailAddressController.text.trim(),
                  //       "password": _passwordController.text.trim(),
                  //     };

                  //     await FirebaseFirestore.instance
                  //         .collection("Register")
                  //         .add(data);

                  //     setState(() {
                  //       loader = false;
                  //     });

                  //     RouteGenerator.navigateToPage(
                  //       context,
                  //       Routes.bottomNavBarRoute,
                  //     );

                  //     DisplaySnackbar.show(context, signupSuccessfullStr);
                  //   } catch (e) {
                  //      print(e);
                  //     setState(() {
                  //       loader = false;
                  //     });

                  //     DisplaySnackbar.show(context, signupFailedStr);
                  //   }
                },

                child: Text(SignupStr),
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
                  CustomText(data: alreadyHaveanAccountStr, fontSize: 20),
                  CustomInkwell(
                    child: CustomText(
                      data: loginStr,
                      color: primaryColor,
                      fontSize: 20,
                    ),
                    onTap: () {
                      RouteGenerator.navigateToPage(context, Routes.loginRoute);
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
