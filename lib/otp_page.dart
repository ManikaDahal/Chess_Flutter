import 'package:chess_game/reset_password.dart';
import 'package:chess_game/utils/color_utils.dart';
import 'package:chess_game/utils/route_const.dart';
import 'package:chess_game/utils/route_generator.dart';
import 'package:chess_game/utils/string_utils.dart';
import 'package:chess_game/widgets/custom_elevatedButton.dart';
import 'package:chess_game/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            CircleAvatar(
              backgroundColor: foregroundColor,
              child: IconButton(onPressed: (){
                 RouteGenerator.navigateToPage(context, Routes.forgotPasswordRoute);
              }, icon: Icon(Icons.arrow_back)),
            ),
            SizedBox(height: 20,),
            Center(
              child: CustomText(data: verifyAccountStr, fontSize: 25,fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            OtpTextField(
              numberOfFields: 4,
              showFieldAsBox: true,
              enabledBorderColor: Colors.grey,
              borderColor: blackColor,

            ),
            SizedBox(height: 40,),
            CustomElevatedbutton(onPressed: (){
              RouteGenerator.navigateToPage(context, Routes.resetPasswordRoute);
            }, child: Text(verifyStr,style: TextStyle(fontSize: 18),))
              
              
          ],
        ),
      )
     
    );
  }
}