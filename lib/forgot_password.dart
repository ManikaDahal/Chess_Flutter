import 'package:chess_game/utils/color_utils.dart';
import 'package:chess_game/utils/route_const.dart';
import 'package:chess_game/utils/route_generator.dart';
import 'package:chess_game/utils/string_utils.dart';
import 'package:chess_game/widgets/custom_elevatedButton.dart';
import 'package:chess_game/widgets/custom_text.dart';
import 'package:chess_game/widgets/custom_textFormField.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              backgroundColor: foregroundColor,
              child: IconButton(
                onPressed: () {
                  RouteGenerator.navigateToPage(context, Routes.loginRoute);
                },
                icon: Icon(Icons.arrow_back),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: CustomText(
                data: forgotPasswordStr,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
        
            SizedBox(height: 20),
            CustomTextformfield(
              hintText: emailAddressStr,
              validator: (p0) {
                if (p0 == null || p0.isEmpty) {
                  return validateEmailAddressStr;
                }
                return null;
              },
            ),
            SizedBox(height: 20,),
            CustomElevatedbutton(onPressed: (){
               RouteGenerator.navigateToPage(context, Routes.enterOTPRoute);
            }, child:Text(sendCodeStr,style: TextStyle(fontSize: 18)),),
          ],
        ),
      ),
    );
  }
}
