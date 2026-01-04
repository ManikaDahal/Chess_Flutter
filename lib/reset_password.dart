import 'package:chess_game/utils/color_utils.dart';
import 'package:chess_game/utils/route_const.dart';
import 'package:chess_game/utils/route_generator.dart';
import 'package:chess_game/utils/string_utils.dart';
import 'package:chess_game/widgets/custom_elevatedButton.dart';
import 'package:chess_game/widgets/custom_text.dart';
import 'package:chess_game/widgets/custom_textFormField.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
    final TextEditingController _passwordController = TextEditingController();
        final TextEditingController _confirmPasswordController = TextEditingController();

    bool _isPasswordVisible=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30,),
            CircleAvatar(
              backgroundColor: foregroundColor,
              child: IconButton(onPressed: (){
                RouteGenerator.navigateToPage(context, Routes.enterOTPRoute);
              }, icon:Icon(Icons.arrow_back)),
            ),
            SizedBox(height: 15,),
            Center(child: CustomText(data:newPasswordStr,fontSize: 25,fontWeight: FontWeight.bold, )),
            SizedBox(
              height: 20,
            ),
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

            CustomTextformfield(
              controller: _confirmPasswordController,
              hintText: confirmPasswordStr,
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
                  return validateConfirmPasswordStr;
                }
                return null;
              },
            ),
            SizedBox(height: 20,),

            CustomElevatedbutton(onPressed: (){}, child: Text(resetStr,style: TextStyle(fontSize: 18)),),


          ],
        ),
      ),
    );
  }
}