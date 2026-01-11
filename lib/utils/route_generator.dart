import 'package:chess_game/authentication/reset_password_authentication.dart';
import 'package:chess_game/bottomnav_bar.dart';
import 'package:chess_game/forgot_password.dart';
import 'package:chess_game/login.dart';
import 'package:chess_game/otp_page.dart';
import 'package:chess_game/profile_page.dart';
import 'package:chess_game/reset_password.dart';
import 'package:chess_game/signup.dart';
import 'package:chess_game/ui/chess_board.dart';
import 'package:chess_game/authentication/otp_arguments.dart';
import 'package:chess_game/utils/route_const.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static navigateToPage(
    BuildContext context,
    String route, {
    dynamic arguments,
  }) {
    Navigator.push(
      context,
      generateRoute(RouteSettings(name: route, arguments: arguments)),
    );
  }

  static navigateToPageWithoutStack(
    BuildContext context,
    String route, {
    dynamic arguments,
  }) {
    Navigator.pushAndRemoveUntil(
      context,
      generateRoute(RouteSettings(name: route, arguments: arguments)),
      (route) => false,
    );
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.signupRoute:
        return MaterialPageRoute(builder: (_) => const Signup());
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case Routes.forgotPasswordRoute:
        return MaterialPageRoute(builder: (_) => const ForgotPassword());
      case Routes.enterOTPRoute:
        final args = settings.arguments as OtpArguments;

        return MaterialPageRoute(
          builder: (_) => OtpPage(
            isEmail: args.isEmail,
            contact: args.contact,
            verificationId: args.verificationId,
          ),
        );

      case Routes.resetPasswordRoute:
        final args = settings.arguments as ResetPasswordArguments;

        return MaterialPageRoute(
          builder: (_) =>
              ResetPassword(isEmail: args.isEmail, contact: args.contact),
        );
      case Routes.gameBoardRoute:
        return MaterialPageRoute(builder: (_) => const GameBoard());
      case Routes.bottomNavBarRoute:
        return MaterialPageRoute(builder: (_) => const BottomnavBar());
      case Routes.profileRoute:
        return MaterialPageRoute(builder: (_) => const ProfilePage());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
