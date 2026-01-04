import 'package:chess_game/utils/color_utils.dart';
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
      body: Column(
        children: [
          SizedBox(height: 15),
            CircleAvatar(
              backgroundColor: foregroundColor,
              child: Icon(Icons.close),
              

            ),
        ],
      ),
    );
  }
}