import 'package:evently_app/core/app_assets.dart';
import 'package:evently_app/core/app_style.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          spacing: height*0.02,
          children: [
            Center(child: Image.asset(AppAssets.logo,width: 142,height: 27,)),
            Text('Login to your account',style: AppStyles.semiBold24main,),



          ],
        ),
      ),
    );
  }
}
