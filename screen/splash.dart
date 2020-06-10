import 'package:flutter/material.dart';
import 'package:dmclassik/utils/colors.dart';
import 'package:dmclassik/utils/helper.dart';
class SplashPage extends StatelessWidget {
  SplashPage(){
    Helper.changeStatusBar(StatusBarType.DEFAULT);
  }
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          color: primaryColor,
          image: DecorationImage(
            image: AssetImage("assets/images/bootloader.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: SizedBox(
            width: 150,
            height: 150,
            child: Image(
              image:AssetImage('assets/images/logo.png'),
              width: 150,
              height: 150
            ),
          ),
        )
      ),
    );
  }
}