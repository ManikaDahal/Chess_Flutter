import 'package:chess_game/authentication/auth_services.dart';
import 'package:chess_game/utils/color_utils.dart';
import 'package:chess_game/utils/display_snackBar.dart';
import 'package:chess_game/utils/route_const.dart';
import 'package:chess_game/utils/route_generator.dart';
import 'package:chess_game/utils/string_utils.dart';
import 'package:chess_game/widgets/custom_elevatedButton.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthServices authServices = AuthServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(profilePageStr),
        centerTitle: true,
        backgroundColor: foregroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            CircleAvatar(
              child: Center(
                child: Image.asset(
                  "assets/images/profileImg.png",
                  height: 600,
                  width: 600,
                ),
              ),
            ),
            Spacer(),
            CustomElevatedbutton(
              onPressed: () async {
               try{
                bool? confirmLogout= await showDialog<bool>(
                  builder: (context)=>AlertDialog(title: Text(confirmLogoutStr),
                  content: Text(reConfirmLogoutStr),
                  actions: [
                    TextButton(onPressed: (){
                      Navigator.pop(context,false);
                    }, child: Text("No")),
                    TextButton(onPressed: (){
                        Navigator.pop(context,true);
                    }, child: Text("Yes")),
                  ],
                  ), context: context);
                 if(confirmLogout==true){
                  await authServices.logout();
                RouteGenerator.navigateToPage(context, Routes.loginRoute);
                DisplaySnackbar.show(context, logoutSuccessfulStr);
                 }
               }catch(e){
                DisplaySnackbar.show(context, e.toString());
               }
              },
              child: Text(logoutStr),
            ),
          ],
        ),
      ),
    );
  }
}
