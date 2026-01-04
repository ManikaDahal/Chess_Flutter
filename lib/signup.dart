import 'package:chess_game/utils/color_utils.dart';
import 'package:chess_game/utils/route_const.dart';
import 'package:chess_game/utils/route_generator.dart';
import 'package:chess_game/utils/string_utils.dart';
import 'package:chess_game/widgets/customInkwell.dart';
import 'package:chess_game/widgets/custom_elevatedButton.dart';
import 'package:chess_game/widgets/custom_text.dart';
import 'package:chess_game/widgets/custom_textFormField.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailAddressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool isTermsAndConditionedAgreed=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15),
            CircleAvatar(
              backgroundColor: foregroundColor,
              child: Icon(Icons.close),
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
              controller: _passwordController,
              hintText: passwordStr,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _isPasswordVisible=!_isPasswordVisible;
                  });
                },
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
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
                    onChanged: (bool? value) {
                      setState(() {
                        isTermsAndConditionedAgreed = value! ? true : false;
                      });
                    },
                  ),
                  CustomText(data: agreeTermsAndConditionStr),
                  Spacer(),
                ],
              ),
              
            SizedBox(height: 50),
            CustomElevatedbutton(onPressed: () {

            }, child: Text(SignupStr)),
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
                  CustomText(data: alreadyHaveanAccountStr,fontSize: 20,),
                  CustomInkwell(
                    child: CustomText(data: loginStr, color: primaryColor,fontSize: 20,),
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
      );
  }
}
            
