import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chess_game/utils/display_snackBar.dart';
import 'package:chess_game/utils/route_const.dart';
import 'package:chess_game/utils/route_generator.dart';
import 'package:chess_game/widgets/custom_elevatedButton.dart';
import 'package:chess_game/widgets/custom_text.dart';
import 'package:chess_game/widgets/custom_textFormField.dart';
import 'package:chess_game/utils/string_utils.dart';

class ResetPassword extends StatefulWidget {
  final bool isEmail;
  final String contact; // email or phone

  const ResetPassword({
    super.key,
    required this.isEmail,
    required this.contact,
  });

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reset Password")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              data: widget.isEmail
                  ? "Reset password for ${widget.contact}"
                  : "Phone verified successfully",
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),

            const SizedBox(height: 30),

            // 🔹 EMAIL FLOW
            if (widget.isEmail)
              CustomElevatedbutton(
                onPressed: isLoading
                    ? null
                    : () async {
                        setState(() => isLoading = true);

                        try {
                          await _auth.sendPasswordResetEmail(
                            email: widget.contact,
                          );

                          if (!mounted) return;

                          DisplaySnackbar.show(
                            context,
                            "Password reset link sent to email",
                          );

                          RouteGenerator.navigateToPageWithoutStack(
                            context,
                            Routes.loginRoute,
                          );
                        } on FirebaseAuthException catch (e) {
                          DisplaySnackbar.show(
                            context,
                            e.message ?? "Something went wrong",
                          );
                        }

                        setState(() => isLoading = false);
                      },
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(newPasswordStr),
              ),

            // 🔹 PHONE FLOW
            if (!widget.isEmail)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    data:
                        "Your phone number is verified.\nPlease login again.",
                    fontSize: 16,
                  ),
                  const SizedBox(height: 20),
                  CustomElevatedbutton(
                    onPressed: () {
                      RouteGenerator.navigateToPageWithoutStack(
                        context,
                        Routes.loginRoute,
                      );
                    },
                    child: const Text("Go to Login"),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
