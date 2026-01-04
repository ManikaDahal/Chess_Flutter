import 'package:chess_game/utils/color_utils.dart';
import 'package:chess_game/utils/route_const.dart';
import 'package:chess_game/utils/route_generator.dart';
import 'package:chess_game/utils/string_utils.dart';
import 'package:chess_game/widgets/customInkwell.dart';
import 'package:chess_game/widgets/custom_elevatedButton.dart';
import 'package:chess_game/widgets/custom_text.dart';
import 'package:chess_game/widgets/custom_textFormField.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
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
                    _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: _isPasswordVisible ? Colors.green : Colors.grey,
                  ),
                ),
              ),
              SizedBox(height: 20),
          
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
                       RouteGenerator.navigateToPage(context, Routes.forgotPasswordRoute);
                    },
                    child: Text(
                      forgotPasswordStr,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
              CustomElevatedbutton(
                onPressed: () {
                  // RouteGenerator.navigateToPage(context, Routes.loginRoute);
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
                      SizedBox(width: 30,),
                      CustomElevatedbutton(
                        onPressed: () {},
                        width: MediaQuery.of(context).size.width * 0.25,
                        backgroundColor: Colors.white,
                        child: Image.asset("assets/images/facebook_logo.png",
                        height: 40,),
                      ),
                          ],
                        ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Spacer(),
                    CustomText(data: dontHAveanAccountStr,fontSize: 20,),
                    CustomInkwell(
                      child: CustomText(data: SignupStr, color: primaryColor,fontSize: 20,),
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
    );
  }
}
